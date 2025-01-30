import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../buttons/icon_button_with_background.dart';
import '../buttons/profile_avatar_button.dart';

class CustomAppBar extends HookConsumerWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      scrolledUnderElevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Divider(
          color: Colors.grey[300],
          height: 1.0,
        ),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/icon_1.svg',
            width: 12,
            height: 14,
          ),
          const SizedBox(width: 8),
          const Text(
            'Student Marketplace',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 160,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(color: Color(0xFF4A739C)),
                prefixIcon: Icon(Icons.search, color: Color(0xFF4A739C)),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 11,
                  horizontal: 16,
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        // Notification button
        IconButtonWithBackground(
          icon: const Icon(Icons.notifications_outlined, color: Colors.black),
          onPressed: () {
            // TODO: Navigate to notifications screen
          },
        ),
        const SizedBox(width: 8), // Add space between buttons
        // Favorites button
        IconButtonWithBackground(
          icon: const Icon(Icons.favorite_outline, color: Colors.black),
          onPressed: () {
            // TODO: Navigate to favorites screen
          },
        ),
        const SizedBox(width: 8), // Add space between buttons
        // Cart button
        IconButtonWithBackground(
          icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
          onPressed: () {
            // TODO: Navigate to cart screen
          },
        ),
        const SizedBox(width: 8), // Add space between buttons
        // Profile button
        const ProfileAvatarButton(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(65.0);
}
