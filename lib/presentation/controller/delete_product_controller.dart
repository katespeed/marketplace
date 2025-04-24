import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_flutter_app/domain/models/product.dart';

class DeleteProductController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> showDeleteProductDialog(BuildContext context, Product product) async {
    final passwordController = TextEditingController();
    final passwordVisible = ValueNotifier<bool>(false);

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Product'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Are you sure you want to delete this product?'),
            const SizedBox(height: 16),
            ValueListenableBuilder<bool>(
              valueListenable: passwordVisible,
              builder: (context, isVisible, child) => TextField(
                controller: passwordController,
                obscureText: !isVisible,
                decoration: InputDecoration(
                  labelText: 'Enter your password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      isVisible ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () => passwordVisible.value = !isVisible,
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              try {
                // Re-authenticate user
                final user = _auth.currentUser;
                if (user == null) throw Exception('User not logged in');

                final credential = EmailAuthProvider.credential(
                  email: user.email!,
                  password: passwordController.text,
                );

                await user.reauthenticateWithCredential(credential);

                // Delete product images from storage
                for (final imagePath in product.imageUrls) {
                  try {
                    final ref = _storage.ref(imagePath);
                    await ref.delete();
                  } catch (e) {
                    debugPrint('Error deleting image: $e');
                  }
                }

                // Delete product from Firestore
                await _firestore.collection('products').doc(product.id).delete();

                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Product deleted successfully')),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: ${e.toString()}')),
                  );
                }
              }
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
} 