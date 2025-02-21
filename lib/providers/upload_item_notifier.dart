import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

class UploadItemState {
  final List<XFile> imageFiles;
  final bool isForRent;
  final bool isLoading;

  UploadItemState({
    this.imageFiles = const [],
    this.isForRent = false,
    this.isLoading = false,
  });

  UploadItemState copyWith({
    List<XFile>? imageFiles,
    bool? isForRent,
    bool? isLoading,
  }) {
    return UploadItemState(
      imageFiles: imageFiles ?? this.imageFiles,
      isForRent: isForRent ?? this.isForRent,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class UploadItemNotifier extends StateNotifier<UploadItemState> {
  UploadItemNotifier() : super(UploadItemState());

  final _database = FirebaseDatabase.instance.ref();
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImages() async {
    try {
      final pickedFiles = await _picker.pickMultiImage();
      if (pickedFiles.length <= 10) {
        state = state.copyWith(imageFiles: pickedFiles);
      }
    } catch (e) {
      debugPrint("Error picking images: $e");
    }
  }

  Future<List<String>> encodeImagesToBase64() async {
    List<String> imageBase64List = [];
    for (var file in state.imageFiles) {
      String base64Image = kIsWeb
          ? base64Encode(await file.readAsBytes())
          : base64Encode(await File(file.path).readAsBytes());
      imageBase64List.add(base64Image);
    }
    return imageBase64List;
  }

  Future<void> uploadItem({
    required String title,
    required String price,
    required String description,
    String? rentDescription,
  }) async {
    if (title.isEmpty || price.isEmpty || state.imageFiles.isEmpty) {
      return;
    }

    state = state.copyWith(isLoading: true);

    try {
      List<String> imageBase64List = await encodeImagesToBase64();

      DatabaseReference newProductRef = _database.child('products').push();
      await newProductRef.set({
        'title': title,
        'price': price,
        'description': description,
        'isForRent': state.isForRent,
        'rentDescription': state.isForRent ? rentDescription : '',
        'images': imageBase64List,
      });

    } catch (e) {
      debugPrint("Error uploading item: $e");
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  void toggleIsForRent() {
    state = state.copyWith(isForRent: !state.isForRent);
  }
}

final uploadItemProvider =
StateNotifierProvider<UploadItemNotifier, UploadItemState>(
        (ref) => UploadItemNotifier());
