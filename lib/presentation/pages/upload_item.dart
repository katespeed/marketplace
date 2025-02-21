import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/upload_item_notifier.dart';

class UploadItemPage extends ConsumerWidget {
  const UploadItemPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uploadState = ref.watch(uploadItemProvider);
    final uploadNotifier = ref.read(uploadItemProvider.notifier);

    final titleController = TextEditingController();
    final priceController = TextEditingController();
    final descriptionController = TextEditingController();
    final rentDescriptionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Upload Your Item')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ElevatedButton(
                  onPressed: uploadNotifier.pickImages,
                  child: const Text('Pick Images'),
                ),
              ),
              const SizedBox(height: 10),
              if (uploadState.imageFiles.isNotEmpty)
                Wrap(
                  spacing: 10,
                  children: uploadState.imageFiles.map((file) {
                    return kIsWeb
                        ? Image.network(
                      file.path,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    )
                        : Image.file(
                      File(file.path),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    );
                  }).toList(),
                ),
              const SizedBox(height: 20),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              Row(
                children: [
                  Checkbox(
                    value: uploadState.isForRent,
                    onChanged: (_) => uploadNotifier.toggleIsForRent(),
                  ),
                  const Text('For Rent')
                ],
              ),
              if (uploadState.isForRent)
                TextField(
                  controller: rentDescriptionController,
                  decoration: const InputDecoration(labelText: 'Rent Description'),
                ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: uploadState.isLoading
                      ? null
                      : () {
                    uploadNotifier.uploadItem(
                      title: titleController.text,
                      price: priceController.text,
                      description: descriptionController.text,
                      rentDescription: rentDescriptionController.text,
                    );
                  },
                  child: uploadState.isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Upload Item'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
