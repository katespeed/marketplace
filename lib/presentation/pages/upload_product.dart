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

  Future<void> submitProduct(BuildContext context, WidgetRef ref) async {
    try {
      final imageBytes = ref.read(imageProvider);
      if (imageBytes == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select an image')),
        );
        return;
      }

      // Upload image to Firebase Storage
      final storageRef = FirebaseStorage.instance.ref();
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final productImageRef = storageRef.child('products/$fileName');
      
      await productImageRef.putData(
        imageBytes,
        SettableMetadata(contentType: 'image/jpeg'),
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
        'imageUrl': imageUrl,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // 成功したらフォームをクリア
      ref.read(imageProvider.notifier).state = null;
      titleController.clear();
      priceController.clear();
      descriptionController.clear();

      // 成功メッセージを表示
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product uploaded successfully')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading product: $e')),
      );
    }
  }
}
