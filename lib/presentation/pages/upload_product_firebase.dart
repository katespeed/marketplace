import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final titleControllerProvider = StateProvider((ref) => TextEditingController());
final priceControllerProvider = StateProvider((ref) => TextEditingController());
final descriptionControllerProvider =
    StateProvider((ref) => TextEditingController());

/// Function to submit a product to Firestore
Future<void> submitProduct(BuildContext context, WidgetRef ref) async {
  final user = FirebaseAuth.instance.currentUser; // Get current user (seller)
  if (user == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text("You must be logged in to upload a product.")),
    );
    return;
  }

  final title = ref.read(titleControllerProvider).text.trim();
  final price = double.tryParse(ref.read(priceControllerProvider).text.trim());
  final description = ref.read(descriptionControllerProvider).text.trim();

  if (title.isEmpty || price == null || description.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please fill all fields correctly.")),
    );
    return;
  }

  try {
    // Fetch seller's PayPal email from Firestore
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    String? sellerPayPalEmail = userDoc.exists ? userDoc['paypalEmail'] : null;

    if (sellerPayPalEmail == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text("You need to add your PayPal email in profile settings.")),
      );
      return;
    }

    // Add product to Firestore with sellerId and PayPal email
    await FirebaseFirestore.instance.collection('products').add({
      'title': title,
      'price': price,
      'description': description,
      'sellerId': user.uid, // Save seller's Firebase UID
      'sellerPayPal': sellerPayPalEmail, // Store seller's PayPal email
      'created_at': Timestamp.now(),
      'imageUrls': ['https://via.placeholder.com/100'],
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Product uploaded successfully!")),
    );

    // Clear fields after upload
    ref.read(titleControllerProvider).clear();
    ref.read(priceControllerProvider).clear();
    ref.read(descriptionControllerProvider).clear();
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error uploading product: $e")),
    );
  }
}
