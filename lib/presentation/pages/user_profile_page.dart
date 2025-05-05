// lib/presentation/pages/user_profile_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../components/profile/profile_sales.dart';
import '../components/profile/profile_reviews.dart';

// 1) Provider to fetch & clean up the user's profileImagePath from Storage
final userAvatarUrlProvider =
    FutureProvider.family<String?, String>((ref, imagePath) async {
  if (imagePath.isEmpty) return null;
  try {
    final refStorage = FirebaseStorage.instance.ref(imagePath);
    final url = await refStorage.getDownloadURL();
    return url.split('?')[0];
  } catch (e) {
    debugPrint('Error loading avatar URL: $e');
    return null;
  }
});

class UserProfilePage extends ConsumerWidget {
  final String userId;
  const UserProfilePage({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .snapshots(),
      builder: (context, userSnap) {
        // Error state
        if (userSnap.hasError) {
          return Scaffold(
            appBar: AppBar(title: const Text('Profile')),
            body: const Center(child: Text('Error loading profile')),
          );
        }
        // Loading state
        if (!userSnap.hasData) {
          return Scaffold(
            appBar: AppBar(title: const Text('Profile')),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        // Extract dynamic data
        final data = userSnap.data!.data()! as Map<String, dynamic>;
        final name = data['name'] as String? ?? 'Unknown';
        final email = data['email'] as String? ?? '';
        final handle = email.contains('@') ? email.split('@').first : email;
        final bio = data['bio'] as String?;
        final imgPath = data['profileImagePath'] as String? ?? '';

        // kick off the avatar loader
        final avatarAsync = ref.watch(userAvatarUrlProvider(imgPath));

        return Scaffold(
          appBar: AppBar(title: Text(name)),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ─── Header ──────────────────────────
                Row(
                  children: [
                    avatarAsync.when(
                      data: (url) => CircleAvatar(
                        radius: 40,
                        backgroundImage: url != null ? NetworkImage(url) : null,
                        child: url == null
                            ? const Icon(Icons.person, size: 40)
                            : null,
                      ),
                      loading: () => const CircleAvatar(
                        radius: 40,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      error: (_, __) => const CircleAvatar(
                        radius: 40,
                        child: Icon(Icons.error),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          handle,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // ─── Bio ─────────────────────────────
                const Text('Bio',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(
                  // if bio exists show it, otherwise show placeholder
                  bio?.isNotEmpty == true ? bio! : 'No bio provided yet.',
                  style: const TextStyle(fontSize: 16),
                ),

                const SizedBox(height: 24),

                // ─── Sales ────────────────────────────
                const Text(
                  'Sales',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ProfileSales(userId: userId),

                const SizedBox(height: 24),

                // ─── Reviews ─────────────────────────
                const Text(
                  'Reviews',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ProfileReviews(userId: userId),
              ],
            ),
          ),
        );
      },
    );
  }
}
