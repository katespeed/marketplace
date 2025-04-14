import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class ProfileHeader extends StatelessWidget {
  final User? user;

  const ProfileHeader({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: user?.photoURL != null
                  ? CachedNetworkImageProvider(user!.photoURL!)
                  : null,
              child: user?.photoURL == null
                  ? const Icon(Icons.person, size: 40)
                  : null,
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => _updateProfileImage(context),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user?.displayName ?? '@user',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(user?.email ?? 'User@example.com'),
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
            user?.email != null
                ? user!.email!.split('@')[0]  // Extracts the part before "@"
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
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "I'm a student at Astate Jonesboro. I love to read.",
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Future<void> _updateProfileImage(BuildContext context) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
      );
      
      if (image == null) return;

      // 画像のパスを取得
      final String imagePath = image.path;
      print('Selected image path: $imagePath'); // デバッグ用

      // Firestoreのユーザードキュメントを更新
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({'profileImage': imagePath});

      // Firebase Authのプロフィールも更新
      await user!.updatePhotoURL(imagePath);

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update image: $e')),
      );
    }
  }
}
