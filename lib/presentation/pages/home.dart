import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_app/presentation/components/appbar/appbar.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                context.push('/product-list');
              },
              child: const Text('Go to Product List'),
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