import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

class UploadItemPage extends StatefulWidget {
  const UploadItemPage({super.key});

  @override
  UploadItemPageState createState() => UploadItemPageState();
}

class UploadItemPageState extends State<UploadItemPage> {
  final _database = FirebaseDatabase.instance.ref();
  final ImagePicker _picker = ImagePicker();
  List<XFile>? _imageFiles = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _rentDescriptionController =
      TextEditingController();
  bool isForRent = false;
  bool isLoading = false;

  Future<void> pickImages() async {
    try {
      final pickedFiles = await _picker.pickMultiImage();
      if (pickedFiles.length <= 10) {
        setState(() {
          _imageFiles = pickedFiles;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You can upload up to 10 images only!')),
        );
      }
    } catch (e) {
      debugPrint("Error picking images: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Failed to pick images. Please try again.')),
      );
    }
  }

  Future<List<String>> encodeImagesToBase64() async {
    List<String> imageBase64List = [];
    try {
      for (var file in _imageFiles!) {
        String base64Image;
        if (kIsWeb) {
          base64Image = base64Encode(await file.readAsBytes());
        } else {
          base64Image = base64Encode(File(file.path).readAsBytesSync());
        }
        imageBase64List.add(base64Image);
      }
    } catch (e) {
      debugPrint("Error encoding images: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to encode images.')),
      );
    }
    return imageBase64List;
  }

  Future<void> uploadItem() async {
    if (_titleController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _imageFiles!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Please fill all required fields and upload at least one image!')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      List<String> imageBase64List = await encodeImagesToBase64();

      // Save the product data with images as Base64 in Realtime Database
      DatabaseReference newProductRef = _database.child('products').push();
      await newProductRef.set({
        'title': _titleController.text,
        'price': _priceController.text,
        'description': _descriptionController.text,
        'isForRent': isForRent,
        'rentDescription': isForRent ? _rentDescriptionController.text : '',
        'images': imageBase64List,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product Uploaded Successfully!')),
      );
      Navigator.pop(context);
    } catch (e) {
      debugPrint("Error uploading item: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Failed to upload item. Please try again.')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  onPressed: pickImages,
                  child: const Text('Pick Images'),
                ),
              ),
              const SizedBox(height: 10),
              if (_imageFiles != null && _imageFiles!.isNotEmpty)
                Wrap(
                  spacing: 10,
                  children: _imageFiles!.map((file) {
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
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              Row(
                children: [
                  Checkbox(
                    value: isForRent,
                    onChanged: (value) {
                      setState(() {
                        isForRent = value!;
                      });
                    },
                  ),
                  const Text('For Rent')
                ],
              ),
              if (isForRent)
                TextField(
                  controller: _rentDescriptionController,
                  decoration:
                      const InputDecoration(labelText: 'Rent Description'),
                ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: isLoading ? null : uploadItem,
                  child: isLoading
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
