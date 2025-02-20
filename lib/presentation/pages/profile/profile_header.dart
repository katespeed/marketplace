import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileHeader extends StatelessWidget {
  final User? user;

  const ProfileHeader({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: user?.photoURL != null
              ? CachedNetworkImageProvider(user!.photoURL!)
              : null,
          child: user?.photoURL == null ? Icon(Icons.person, size: 40) : null,
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user?.displayName ?? 'Jenny Johnson',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(user?.email ?? 'jennyjohnson@example.com'),
          ],
        ),
      ],
    );
  }
}
