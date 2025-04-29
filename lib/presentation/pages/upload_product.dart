import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_flutter_app/presentation/components/appbar/appbar.dart';
import 'package:my_flutter_app/providers/upload_product_controller.dart';
import 'package:my_flutter_app/providers/product_provider.dart';

class UploadProductPage extends ConsumerWidget {
  const UploadProductPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageBytes = ref.watch(imageProvider);
    final titleController = ref.watch(titleControllerProvider);
    final priceController = ref.watch(priceControllerProvider);
    final descriptionController = ref.watch(descriptionControllerProvider);

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.grey.shade100,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildImageUploadArea(imageBytes, ref),
                const SizedBox(height: 24),
                _buildFormField(
                  controller: titleController,
                  label: 'Product Name',
                  icon: Icons.title,
                ),
                const SizedBox(height: 16),
                _buildFormField(
                  controller: priceController,
                  label: 'Price',
                  icon: Icons.attach_money,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                _buildFormField(
                  controller: descriptionController,
                  label: 'Description',
                  icon: Icons.description,
                  maxLines: 4,
                ),
                const SizedBox(height: 32),
                _buildUploadButton(context, ref),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageUploadArea(Uint8List? imageBytes, WidgetRef ref) {
    return GestureDetector(
      onTap: () => pickImage(ref),
      child: Container(
        height: 250,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: imageBytes == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_photo_alternate_outlined,
                    size: 48,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Select Image',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                    ),
                  ),
                ],
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.memory(
                  imageBytes,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
      ),
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue.shade400, width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildUploadButton(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () => submitProduct(context, ref),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue.shade600,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
      ),
      child: const Text(
        'Upload Product',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  String _getFileExtension(List<int> bytes) {
    if (bytes.length < 2) return '.jpg';
    
    if (bytes[0] == 0xFF && bytes[1] == 0xD8) return '.jpg';
    if (bytes[0] == 0x89 && bytes[1] == 0x50) return '.png';
    if (bytes[0] == 0x47 && bytes[1] == 0x49) return '.gif';
    if (bytes[0] == 0x42 && bytes[1] == 0x4D) return '.bmp';
    if (bytes[0] == 0x52 && bytes[1] == 0x49) return '.webp';
    
    return '.jpg'; // デフォルト
  }

  Future<void> submitProduct(BuildContext context, WidgetRef ref) async {
    try {
      final imageBytes = ref.read(imageProvider);
      if (imageBytes == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select an image')),
        );
        return;
      }

      // Get file extension based on MIME type
      final extension = _getFileExtension(imageBytes);
      final fileName = '${DateTime.now().millisecondsSinceEpoch}$extension';
      final productImageRef = FirebaseStorage.instance.ref().child('products/$fileName');
      
      // Determine content type based on extension
      final contentType = extension == '.png' 
          ? 'image/png' 
          : extension == '.gif' 
              ? 'image/gif' 
              : extension == '.webp' 
                  ? 'image/webp' 
                  : 'image/jpeg';

      await productImageRef.putData(
        imageBytes,
        SettableMetadata(contentType: contentType),
      );

      // Save product information to Firestore
      final titleController = ref.read(titleControllerProvider);
      final priceController = ref.read(priceControllerProvider);
      final descriptionController = ref.read(descriptionControllerProvider);

      // Get user information
      final user = FirebaseAuth.instance.currentUser;
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .get();
      
      final userData = userDoc.data() as Map<String, dynamic>?;

      await FirebaseFirestore.instance.collection('products').add({
        'title': titleController.text,
        'price': int.parse(priceController.text),
        'description': descriptionController.text,
        'imageUrls': ['products/$fileName'],
        'createdAt': FieldValue.serverTimestamp(),
        'sellerId': user?.uid,
        'sellerPayPal': user?.email,
        'sellerName': userData?['name'] ?? user?.displayName,
        'sellerBio': userData?['bio'],
        'sellerProfileImage': userData?['profileImage'],
        'isAvailable': true,
      });

      // clear fields after upload
      ref.read(imageProvider.notifier).state = null;
      titleController.clear();
      priceController.clear();
      descriptionController.clear();

      // show success message and navigate back to home
      if (context.mounted) {
        // Trigger refresh of product list
        ref.read(refreshTriggerProvider.notifier).state++;
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product uploaded successfully')),
        );
        Navigator.of(context).pop(); // ホーム画面に戻る
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading product: $e')),
      );
    }
  }
}
