import 'package:flutter/material.dart';

class UserInfoListTile extends StatelessWidget {
  const UserInfoListTile({
    super.key,
    required this.icon,
    required this.title,
  });

  final Icon icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text(title),
    );
  }
} 