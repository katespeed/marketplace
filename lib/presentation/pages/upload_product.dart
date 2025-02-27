import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../providers/product_provider.dart';

final imageProvider = StateProvider<Uint8List?>((ref) => null);
final titleControllerProvider = Provider((ref) => TextEditingController());
final priceControllerProvider = Provider((ref) => TextEditingController());
final descriptionControllerProvider = Provider((ref) => TextEditingController());

class UploadProductPage extends ConsumerWidget {
  const UploadProductPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageBytes = ref.watch(imageProvider);
    final titleController = ref.watch(titleControllerProvider);
    final priceController = ref.watch(priceControllerProvider);
    final descriptionController = ref.watch(descriptionControllerProvider);

    Future<void> pickImage() async {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        ref.read(imageProvider.notifier).state = bytes;
      }
    }

    void submitProduct() {
      if (titleController.text.isEmpty || priceController.text.isEmpty || descriptionController.text.isEmpty || imageBytes == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill all fields and select an image')),
        );
        return;
      }

      // Create a new product object
      final newProduct = Product(
        title: titleController.text,
        price: priceController.text,
        description: descriptionController.text,
        image: imageBytes,
      );

      // Add product to the list provider
      ref.read(productListProvider.notifier).addProduct(newProduct);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product uploaded successfully!')),
      );

      // Clear form after submission
      titleController.clear();
      priceController.clear();
      descriptionController.clear();
      ref.read(imageProvider.notifier).state = null;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Upload Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: pickImage,
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
                decoration: const InputDecoration(labelText: 'Product Title', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Price', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'Description', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: submitProduct,
                child: const Text('Upload Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
