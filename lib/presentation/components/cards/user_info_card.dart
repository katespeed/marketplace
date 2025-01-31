import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_flutter_app/presentation/components/buttons/delete_account_button.dart';
import 'user_info_list_tile.dart';

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
        UserInfoListTile(
          icon: const Icon(Icons.person),
          title: 'Name: ${user.displayName ?? 'Not set'}',
        ),
        UserInfoListTile(
          icon: const Icon(Icons.email),
          title: 'Email: ${user.email}',
        ),
        UserInfoListTile(
          icon: const Icon(Icons.verified),
          title: 'Email Verified: ${user.emailVerified ? 'Yes' : 'No'}',
        ),
        const SizedBox(height: 16),
        const DeleteAccountButton(),
      ],
    );
  }
} 