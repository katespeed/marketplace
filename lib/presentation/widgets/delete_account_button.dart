import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import '../../providers/auth_provider.dart';

class DeleteAccountButton extends HookConsumerWidget {
  const DeleteAccountButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton.icon(
      onPressed: () => _showDeleteAccountDialog(context, ref),
      icon: const Icon(Icons.delete_forever, color: Colors.red),
      label: const Text(
        'Delete Account',
        style: TextStyle(color: Colors.red),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red.withOpacity(0.1),
      ),
    );
  }
}

Future<void> _showDeleteAccountDialog(BuildContext context, WidgetRef ref) {
  final passwordController = useTextEditingController();

  return showDialog(
    context: context,
    builder: (context) => DeleteAccountDialog(
      passwordController: passwordController,
      onConfirm: () => _handleAccountDeletion(
        context,
        ref,
        passwordController,
      ),
    ),
  );
}

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({
    super.key,
    required this.passwordController,
    required this.onConfirm,
  });

  final TextEditingController passwordController;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Account'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'This action cannot be undone. Please enter your password to confirm.',
            style: TextStyle(color: Colors.red),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: onConfirm,
          child: const Text(
            'Delete',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}

Future<void> _handleAccountDeletion(
  BuildContext context,
  WidgetRef ref,
  TextEditingController passwordController,
) async {
  try {
    await ref
        .read(authProvider.notifier)
        .deleteAccount(passwordController.text);
    
    if (context.mounted) {
      Navigator.pop(context);
      context.go('/login');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account successfully deleted'),
        ),
      );
    }
  } catch (e) {
    if (context.mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
  passwordController.clear();
} 