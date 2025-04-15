import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

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
        final displayName = userData?['displayName'] as String?;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: widget.user?.photoURL != null
                      ? CachedNetworkImageProvider(widget.user!.photoURL!)
                      : null,
                  child: widget.user?.photoURL == null
                      ? const Icon(Icons.person, size: 40)
                      : null,
                ),
                // IconButton(
                //   icon: const Icon(Icons.edit),
                //   onPressed: () => _updateProfileImage(context),
                // ),
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

  // Future<void> _updateProfileImage(BuildContext context) async {
  //   try {
  //     final ImagePicker picker = ImagePicker();
  //     final XFile? image = await picker.pickImage(
  //       source: ImageSource.gallery,
  //       maxWidth: 512,
  //       maxHeight: 512,
  //     );
      
  //     if (image == null) return;

  //     // Get the image path
  //     final String imagePath = image.path;
  //     // print('Selected image path: $imagePath'); // For debugging

  //     // Update user document in Firestore
  //     await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(widget.user!.uid)
  //         .update({'profileImage': imagePath});

  //     // Update Firebase Auth profile as well
  //     await widget.user!.updatePhotoURL(imagePath);

  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to update image: $e')),
  //     );
  //   }
  // }

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
