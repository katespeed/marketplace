import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'delete_account_button.dart';

class UserInfoCard extends StatelessWidget {
  const UserInfoCard({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'User Information',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ListTile(
          leading: const Icon(Icons.person),
          title: Text('Name: ${user.displayName ?? 'Not set'}'),
        ),
        ListTile(
          leading: const Icon(Icons.email),
          title: Text('Email: ${user.email}'),
        ),
        ListTile(
          leading: const Icon(Icons.verified),
          title: Text(
            'Email Verified: ${user.emailVerified ? 'Yes' : 'No'}',
          ),
        ),
        const SizedBox(height: 16),
        const DeleteAccountButton(),
      ],
    );
  }
} 