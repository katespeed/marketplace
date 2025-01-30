import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_app/presentation/components/cards/user_info_card.dart';
import 'package:my_flutter_app/providers/auth_provider.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(authProvider.notifier).signOut();
              if (context.mounted) {
                context.go('/login');
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            authState.when(
              data: (user) => user != null
                  ? UserInfoCard(user: user)
                  : const Text('No user logged in'),
              loading: () => const CircularProgressIndicator(),
              error: (error, stack) => Text('Error: $error'),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: () {
                context.push('/product-list');
              },
              child: const Text('Go to Product List'),
            ),
            ElevatedButton(
              onPressed: () {
                context.push('/profile');
              },
              child: const Text('Go to Profile'),
            ),
            ElevatedButton(
              onPressed: () {
                context.push('/payment');
              },
              child: const Text('Go to Payment'),
            ),
            ElevatedButton(
              onPressed: () {
                context.push('/product-detail');
              },
              child: const Text('Go to Product Detail'),
            ),
          ],
        ),
      ),
    );
  }
}