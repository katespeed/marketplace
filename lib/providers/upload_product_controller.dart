import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../providers/product_provider.dart';

// State Providers
final imageProvider = StateProvider<Uint8List?>((ref) => null);
final titleControllerProvider = Provider((ref) => TextEditingController());
final priceControllerProvider = Provider((ref) => TextEditingController());
final descriptionControllerProvider = Provider((ref) => TextEditingController());

// Image Picker Function
Future<void> pickImage(WidgetRef ref) async {
  final ImagePicker picker = ImagePicker();
  final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    final bytes = await pickedFile.readAsBytes();
    ref.read(imageProvider.notifier).state = bytes;
  }
}

// Product Submission Logic
void submitProduct(BuildContext context, WidgetRef ref) {
  final imageBytes = ref.read(imageProvider);
  final titleController = ref.read(titleControllerProvider);
  final priceController = ref.read(priceControllerProvider);
  final descriptionController = ref.read(descriptionControllerProvider);

  if (titleController.text.isEmpty ||
      priceController.text.isEmpty ||
      descriptionController.text.isEmpty ||
      imageBytes == null) {
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
