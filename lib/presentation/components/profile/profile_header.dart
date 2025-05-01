import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
// ignore: deprecated_member_use
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:mime/mime.dart';

class ProfileHeader extends StatefulWidget {
  final User? user;

  const ProfileHeader({super.key, this.user});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  Stream<DocumentSnapshot>? _userStream;

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      _userStream = FirebaseFirestore.instance
          .collection('users')
          .doc(widget.user!.uid)
          .snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: _userStream,
      builder: (context, snapshot) {
        final userData = snapshot.data?.data() as Map<String, dynamic>?;
        final bio = userData?['bio'] as String?;
        final displayName = userData?['name'] as String?;
        final profileImageUrl = userData?['profileImagePath'] as String?;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => _updateProfileImage(context),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey,
                    backgroundImage: profileImageUrl != null
                        ? NetworkImage(profileImageUrl)
                        : null,
                    child: profileImageUrl == null
                        ? const Icon(Icons.person, size: 40, color: Colors.white)
                        : null,
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          displayName ?? '@user',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        if (FirebaseAuth.instance.currentUser?.uid == widget.user?.uid)
                          IconButton(
                            icon: const Icon(Icons.edit, size: 16),
                            onPressed: () => _editDisplayName(context),
                          ),
                      ],
                    ),
                    Text(widget.user?.email ?? 'User@example.com'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "How others can find you",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.user?.email != null
                    ? widget.user!.email!.split('@')[0]  // Extracts the part before "@"
                    : "@user",
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            ),
            const SizedBox(height: 16),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Bio",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    bio ?? "I'm a student at Astate Jonesboro. I love to read.",
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ),
                if (FirebaseAuth.instance.currentUser?.uid == widget.user?.uid)
                  IconButton(
                    icon: const Icon(Icons.edit, size: 16),
                    onPressed: () => _editBio(context, bio),
                  ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }

  Future<void> _updateProfileImage(BuildContext context) async {
    try {
      // Create file input element
      final input = html.FileUploadInputElement()
        ..accept = 'image/*'
        ..click();

      // Wait for file selection
      await input.onChange.first;
      if (input.files?.isEmpty ?? true) return;

      final file = input.files!.first;
      final reader = html.FileReader();
      reader.readAsArrayBuffer(file);
      await reader.onLoad.first;

      // Show loading indicator
      if (!mounted) return;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      // Get current user data
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.user?.uid)
          .get();
      final currentImageUrl = userData.data()?['profileImagePath'] as String?;

      // Delete old image if exists
      if (currentImageUrl != null) {
        try {
          final oldImageRef = FirebaseStorage.instance.refFromURL(currentImageUrl);
          await oldImageRef.delete();
        } catch (e) {
          print('Error deleting old image: $e');
        }
      }

      // Upload new image
      final bytes = reader.result as Uint8List;
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('users')
          .child('${widget.user?.uid}')
          .child('profile.jpg');
      
      final uploadTask = storageRef.putData(
        bytes,
        SettableMetadata(contentType: lookupMimeType(file.name)),
      );
      final snapshot = await uploadTask;
      final newImageUrl = await snapshot.ref.getDownloadURL();

      // Update Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.user?.uid)
          .update({'profileImagePath': newImageUrl});

      // Close loading indicator
      if (!mounted) return;
      Navigator.pop(context);

    } catch (e) {
      print('Error updating profile image: $e');
      // Close loading indicator if open
      if (mounted && Navigator.canPop(context)) {
        Navigator.pop(context);
      }
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update image: $e')),
        );
      }
    }
  }

  Future<void> _editDisplayName(BuildContext context) async {
    final userData = (await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.user?.uid)
            .get())
        .data();
    final currentDisplayName = userData?['displayName'] as String?;
    
    final TextEditingController controller = TextEditingController(text: currentDisplayName ?? '@user');
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Display Name'),
        content: TextField(
          controller: controller,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              try {
                await widget.user?.updateDisplayName(controller.text);
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.user?.uid)
                    .update({'displayName': controller.text});
                Navigator.pop(context);
                // StreamBuilderが自動的に更新を検知するので、setStateは不要
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to update display name: $e')),
                );
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _editBio(BuildContext context, String? currentBio) async {
    final TextEditingController controller = TextEditingController(
      text: currentBio ?? "I'm a student at Astate Jonesboro. I love to read."
    );
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Bio'),
        content: TextField(
          controller: controller,
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              try {
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.user?.uid)
                    .update({'bio': controller.text});
                Navigator.pop(context);
                // StreamBuilderが自動的に更新を検知するので、setStateは不要
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to update bio: $e')),
                );
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
