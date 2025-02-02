import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:html' as html;
import 'package:my_flutter_app/providers/uploaded_items_provider.dart';

class UploadItemPage extends ConsumerStatefulWidget {
  const UploadItemPage({super.key});

  @override
  ConsumerState<UploadItemPage> createState() => _UploadItemPageState();
}

class _UploadItemPageState extends ConsumerState<UploadItemPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  List<dynamic> _selectedImages = [];
  String _selectedCategory = 'Sell';

  // Function to pick images for both Web and Mobile
  Future<void> _pickImages() async {
    if (kIsWeb) {
      final uploadInput = html.FileUploadInputElement()..accept = 'image/*';
      uploadInput.click();

      uploadInput.onChange.listen((event) {
        final files = uploadInput.files;
        if (files!.isNotEmpty) {
          final reader = html.FileReader();
          reader.readAsArrayBuffer(files[0]);
          reader.onLoadEnd.listen((_) {
            setState(() {
              _selectedImages.add(reader.result as Uint8List);
            });
          });
        }
      });
    } else {
      final picker = ImagePicker();
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _selectedImages.add(pickedFile.path);
        });
      }
    }
  }

  // Function to upload item
  void _uploadItem(BuildContext context, WidgetRef ref) {
    if (_selectedImages.isEmpty ||
        _nameController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Please fill in all fields and add an image.")),
      );
      return;
    }

    final newItem = {
      'name': _nameController.text,
      'price': _priceController.text,
      'images': _selectedImages,
      'description': _descriptionController.text,
      'category': _selectedCategory,
    };

    ref.read(uploadedItemsProvider.notifier).addItem(newItem);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Item uploaded successfully!")),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Upload Item")),
      body: SingleChildScrollView(
        // ✅ Fix: Makes page scrollable
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Upload up to 3 images:"),
              ElevatedButton(
                onPressed: _pickImages,
                child: const Text("Select Images"),
              ),
              _selectedImages.isNotEmpty
                  ? SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _selectedImages.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: kIsWeb
                                ? Image.memory(
                                    _selectedImages[index],
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    _selectedImages[index],
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                          );
                        },
                      ),
                    )
                  : Container(),
              const SizedBox(height: 10),
              const Text("Enter item name:"),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: "Enter item name...",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              const Text("Enter price:"),
              TextField(
                controller: _priceController,
                decoration: const InputDecoration(
                  hintText: "Enter price...",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              const Text("Enter description:"),
              TextField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: "Describe your item...",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              const Text("Select category:"),
              DropdownButton<String>(
                value: _selectedCategory,
                items: ['Sell', 'Rent'].map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                  });
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () => _uploadItem(context, ref),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                  ),
                  child: const Text(
                    "Upload Item",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
