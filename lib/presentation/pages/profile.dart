import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_flutter_app/presentation/components/appbar/appbar.dart';
import 'package:my_flutter_app/presentation/components/profile/profile_header.dart';
import 'package:my_flutter_app/presentation/components/profile/profile_reviews.dart';
import 'package:my_flutter_app/presentation/components/profile/profile_sales.dart';
import 'package:my_flutter_app/applications/firebase_auth/auth_service.dart';
import 'package:my_flutter_app/presentation/controller/delete_account_controller.dart';

class ProfilePage extends HookConsumerWidget {
  const ProfilePage({super.key});

  void _showChangePasswordDialog(
      BuildContext context, AuthService authService) {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    final currentPasswordVisible = ValueNotifier<bool>(false);
    final newPasswordVisible = ValueNotifier<bool>(false);
    final confirmPasswordVisible = ValueNotifier<bool>(false);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ValueListenableBuilder<bool>(
              valueListenable: currentPasswordVisible,
              builder: (context, isVisible, child) => TextField(
                controller: currentPasswordController,
                obscureText: !isVisible,
                decoration: InputDecoration(
                  labelText: 'Current Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      isVisible ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () => currentPasswordVisible.value = !isVisible,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ValueListenableBuilder<bool>(
              valueListenable: newPasswordVisible,
              builder: (context, isVisible, child) => TextField(
                controller: newPasswordController,
                obscureText: !isVisible,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      isVisible ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () => newPasswordVisible.value = !isVisible,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ValueListenableBuilder<bool>(
              valueListenable: confirmPasswordVisible,
              builder: (context, isVisible, child) => TextField(
                controller: confirmPasswordController,
                obscureText: !isVisible,
                decoration: InputDecoration(
                  labelText: 'Confirm New Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      isVisible ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () => confirmPasswordVisible.value = !isVisible,
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (newPasswordController.text !=
                  confirmPasswordController.text) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('New passwords do not match')),
                );
                return;
              }

              try {
                await authService.changePassword(
                  currentPasswordController.text,
                  newPasswordController.text,
                );
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Password changed successfully')),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: ${e.toString()}')),
                  );
                }
              }
            },
            child: const Text('Change'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User user = FirebaseAuth.instance.currentUser!;
    final authService = ref.watch(authServiceProvider);
    final deleteAccountController = ref.watch(deleteAccountControllerProvider);

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileHeader(user: user),
            const SizedBox(height: 16),
            ProfileSales(userId: user.uid),
            const SizedBox(height: 16),
            ProfileReviews(userId: user.uid),
            const SizedBox(height: 32),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () =>
                        _showChangePasswordDialog(context, authService),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize: const Size(200, 40),
                    ),
                    child: const Text('Change Password'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      await authService.signOut();
                      if (context.mounted) {
                        context.pushReplacement('/login');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize: const Size(200, 40),
                    ),
                    child: const Text('Sign Out'),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => deleteAccountController
                        .showDeleteAccountDialog(context),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red,
                      minimumSize: const Size(200, 40),
                    ),
                    child: const Text('Delete Account'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
