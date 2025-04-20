import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

final imageProvider = StateProvider<Uint8List?>((ref) => null);

Future<void> pickImage(WidgetRef ref) async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);

  if (image != null) {
    final bytes = await image.readAsBytes();
    ref.read(imageProvider.notifier).state = bytes;
  }
}

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
  final priceText = ref.read(priceControllerProvider).text.trim();
  final description = ref.read(descriptionControllerProvider).text.trim();

  double? price = double.tryParse(priceText); // Convert price to double

  if (title.isEmpty || price == null || description.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please enter valid product details.")),
    );
    return;
  }

  try {
    // Fetch seller's PayPal email from Firestore
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    final data = userDoc.data() as Map<String, dynamic>?;

    String? sellerPayPalEmail = data != null && data.containsKey('paypalEmail')
        ? data['paypalEmail']
        : null;

    if (sellerPayPalEmail == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text("You need to add your PayPal email in profile settings.")),
      );
      return;
    }

    // Generate a unique ID for the product
    DocumentReference productRef =
        FirebaseFirestore.instance.collection('products').doc();

    // Save product to Firestore
    await productRef.set({
      'id': productRef.id, // Unique product ID
      'title': title,
      'price': price,
      'description': description,
      'sellerId': user.uid, // Save seller's Firebase UID
      'sellerPayPal': sellerPayPalEmail, // Store seller's PayPal email
      'createdAt': Timestamp.now(),
      'isAvailable': true,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Product uploaded successfully!")),
    );

    // Clear input fields after submission
    ref.read(titleControllerProvider).clear();
    ref.read(priceControllerProvider).clear();
    ref.read(descriptionControllerProvider).clear();
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error uploading product: $e")),
    );
  }
}
