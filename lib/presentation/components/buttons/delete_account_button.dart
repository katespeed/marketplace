import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_app/presentation/components/buttons/custom_button.dart';
import 'package:my_flutter_app/providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DeleteAccountButton extends HookConsumerWidget {
  const DeleteAccountButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomButton(
      onPressed: () => _showDeleteConfirmationDialog(context, ref),
      backgroundColor: Colors.red,
      textColor: Colors.white,
      text: 'Delete Account',
    );
  }

  Future<void> _showDeleteConfirmationDialog(BuildContext context, WidgetRef ref) async {
    String? errorText;
    bool shouldRetry;

    do {
      shouldRetry = false;
      final passwordController = TextEditingController();

      try {
        final bool? confirmWithPassword = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete Account'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'This action cannot be undone. Please enter your password to confirm.',
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
                    errorText: errorText,
                  ),
                  obscureText: true,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        );

        if (confirmWithPassword == true) {
          await ref.read(authProvider.notifier).deleteAccount(
            password: passwordController.text,
          );
          if (context.mounted) {
            context.go('/login');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Account successfully deleted')),
            );
          }
        }
      } catch (e) {
        if (e is FirebaseAuthException && e.code == 'wrong-password') {
          errorText = 'Incorrect password. Please try again.';
          shouldRetry = true;
        } else if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        passwordController.dispose();
      }
    } while (shouldRetry && context.mounted);
  }
} 