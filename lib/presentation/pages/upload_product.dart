import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/upload_product_controller.dart';
import '../components/appbar/appbar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () => pickImage(ref),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: imageBytes == null
                      ? const Center(child: Text('Tap to select an image'))
                      : Image.memory(imageBytes, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                    labelText: 'Product Title', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: 'Price', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                    labelText: 'Description', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => submitProduct(context, ref),
                child: const Text('Upload Product'),
              ),
            ],
          ),
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

      // Get image URL
      final imageUrl = await productImageRef.getDownloadURL();

      // Save product information to Firestore
      final titleController = ref.read(titleControllerProvider);
      final priceController = ref.read(priceControllerProvider);
      final descriptionController = ref.read(descriptionControllerProvider);

      await FirebaseFirestore.instance.collection('products').add({
        'title': titleController.text,
        'price': int.parse(priceController.text),
        'description': descriptionController.text,
        'imageUrls': ['products/$fileName'],
        'createdAt': FieldValue.serverTimestamp(),
        'sellerId': FirebaseAuth.instance.currentUser?.uid,
        'sellerPayPal': FirebaseAuth.instance.currentUser?.email,
      });

      // clear fields after upload
      ref.read(imageProvider.notifier).state = null;
      titleController.clear();
      priceController.clear();
      descriptionController.clear();

      // show success message and navigate back to home
      if (context.mounted) {
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
