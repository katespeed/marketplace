import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_flutter_app/applications/firebase_auth/auth_service.dart';

final deleteAccountControllerProvider = Provider((ref) {
  return DeleteAccountController(ref.watch(authServiceProvider));
});

class DeleteAccountController {
  DeleteAccountController(this._authService);
  
  final AuthService _authService;

  Future<void> deleteAccount(String password) async {
    try {
      await _authService.deleteAccount(password: password);
    } catch (e) {
      throw Exception('Failed to delete accounte: $e');
    }
  }

  Future<void> showDeleteAccountDialog(BuildContext context) async {
    final passwordController = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Are you sure you want to delete your account?\nThis action cannot be undone.',
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Enter password',
                border: OutlineInputBorder(),
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
              try {
                await deleteAccount(passwordController.text);
                if (context.mounted) {
                  context.pushReplacement('/login');
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Failed to delete account')),
                  );
                }
              }
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
} 