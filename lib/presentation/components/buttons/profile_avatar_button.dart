import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_flutter_app/applications/firebase_auth/auth_service.dart';

class ProfileAvatarButton extends HookConsumerWidget {
  const ProfileAvatarButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authService = ref.watch(authServiceProvider);
    final authStateAsyncValue = ref.watch(
      StreamProvider((ref) => authService.authStateChanges())
    );

    return Padding(
      padding: const EdgeInsets.only(right: 16.0, left: 8.0),
      child: GestureDetector(
        onTap: () {
          context.push('/profile');
        },
        child: authStateAsyncValue.when(
          data: (user) {
            final displayName = user?.displayName ?? 'User';
            final photoUrl = user?.photoURL;
            
            return CircleAvatar(
              radius: 16,
              backgroundColor: Colors.grey[300],
              child: ClipOval(
                child: photoUrl != null
                    ? Image.network(
                        photoUrl,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildDefaultAvatar(displayName);
                        },
                      )
                    : _buildDefaultAvatar(displayName),
              ),
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (_, __) => CircleAvatar(
            radius: 16,
            backgroundColor: Colors.grey[300],
            child: const Icon(Icons.error, color: Colors.red),
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultAvatar(String displayName) {
    return Image.network(
      'https://ui-avatars.com/api/?name=${Uri.encodeComponent(displayName)}&background=random',
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.person, color: Colors.black54);
      },
    );
  }
} 