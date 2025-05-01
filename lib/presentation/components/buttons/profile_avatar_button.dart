import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_flutter_app/applications/firebase_auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileAvatarButton extends HookConsumerWidget {
  const ProfileAvatarButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authService = ref.watch(authServiceProvider);
    final user = authService.currentUser;

    return Padding(
      padding: const EdgeInsets.only(right: 16.0, left: 8.0),
      child: GestureDetector(
        onTap: () {
          context.push('/profile');
        },
        child: user == null
            ? CircleAvatar(
                radius: 16,
                backgroundColor: Colors.grey[300],
                child: ClipOval(
                  child: _buildDefaultAvatar('User'),
                ),
              )
            : FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(user.uid)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    debugPrint('Error fetching user data: ${snapshot.error}');
                    return CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.grey[300],
                      child: const Icon(Icons.error, color: Colors.red),
                    );
                  }

                  if (!snapshot.hasData) {
                    return CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.grey[300],
                      child: const CircularProgressIndicator(),
                    );
                  }

                  final userData = snapshot.data?.data() as Map<String, dynamic>?;
                  final profileImageUrl = userData?['profileImagePath'] as String?;
                  
                  return CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.grey,
                    child: profileImageUrl != null
                        ? ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: profileImageUrl,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.person,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : const Icon(Icons.person, size: 16, color: Colors.white),
                  );
                },
              ),
      ),
    );
  }

  Widget _buildDefaultAvatar(String displayName) {
    return Image.network(
      'https://ui-avatars.com/api/?name=${Uri.encodeComponent(displayName)}&background=random&color=fff&bold=true',
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Text(
          displayName.isNotEmpty ? displayName[0].toUpperCase() : '?',
          style: const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    );
  }
} 