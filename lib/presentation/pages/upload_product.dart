import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/upload_product_controller.dart';
import '../components/appbar/appbar.dart';


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
                onPressed: () => submitProduct(context, ref),
                child: const Text('Upload Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
