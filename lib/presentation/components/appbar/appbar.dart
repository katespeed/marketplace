import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../pages/chat_list_screen.dart';
import '../buttons/profile_avatar_button.dart';
import 'package:go_router/go_router.dart';
import '../../../providers/product_provider.dart';

class CustomAppBar extends HookConsumerWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = TextEditingController();

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      scrolledUnderElevation: 0,
      toolbarHeight: 65,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Divider(
          color: Colors.grey[300],
          height: 1.0,
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(
            'assets/icon_1.svg',
            width: 12,
            height: 14,
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: () => context.go('/home'),
            child: const Text(
              'Student Marketplace',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 160,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Color(0xFF4A739C)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 16,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search, color: Color(0xFF4A739C)),
                  onPressed: () {
                    ref.read(searchQueryProvider.notifier).state = searchController.text;
                    if (searchController.text.isNotEmpty) {
                      context.go('/search');
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.chat),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ChatListScreen()),
          ),
        ),
        TextButton(
          onPressed: () => context.push('/upload_product'),
          child: const Text(
            'Upload Product',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14,
            ),
          ),
        ),
        TextButton(
          onPressed: () => context.push('/product-list'),
          child: const Text(
            'Product List',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14,
            ),
          ),
        ),
        TextButton(
          onPressed: () => context.push('/payment'),
          child: const Text(
            'My Uploads',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(width: 24), // Spacing between buttons
        const ProfileAvatarButton(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(57.0);
}
