import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text('Login Page'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.push('/home');
              },
              child: const Text('Go to Home'),
            ),
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
                context.push('/product-detail/123');
              },
              child: const Text('Go to Product Detail'),
            ),
          ],
        ),
      ),
    );
  }
}