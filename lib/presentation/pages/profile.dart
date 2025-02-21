import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../components/profile/profile_header.dart';
import '../components/profile/profile_listings.dart';
import '../components/profile/profile_reviews.dart';
import '../components/profile/profile_sales.dart';


class ProfilePage extends HookConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text("User Profile Management")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileHeader(user: user),
            const SizedBox(height: 16),
            ProfileListings(),
            const SizedBox(height: 16),
            ProfileSales(),
            const SizedBox(height: 16),
            ProfileReviews(),
          ],
        ),
      ),
    );
  }
}
