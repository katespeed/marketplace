import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mime/mime.dart';
import 'package:my_flutter_app/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'storage_repository.g.dart';

@Riverpod(keepAlive: true)
StorageRepository storageRepository(StorageRepositoryRef ref) =>
    StorageRepository(ref);

class StorageRepository {
  StorageRepository(this.ref);

  final Ref ref;

  StorageRepository get storageRepository =>
      ref.read(storageRepositoryProvider);

  /// Firebase Storage
  // FirebaseStorage get storage => FirebaseStorage.instance;
  static final storage = FirebaseStorage.instance;

  static Future<Image?> downloadImage(String downloadImagePath) async {
    try {
      final url = await storage.ref().child(downloadImagePath).getDownloadURL();
      return Image.network(
        url,
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                : null,
          );
        },
        errorBuilder: (context, error, stackTrace) {
          logger.e('Error loading image: $error');
          return const Icon(Icons.error);
        },
      );
    } catch (e) {
      logger.e('Error downloading image: $e');
      return null;
    }
  }

  static Future<List<String>> uploadImage({
    required Uint8List selectedNewImage,
    required String campaignCode,
    String? previousImagePath,
    String? selectedImageName,
  }) async {
    try {
      if (previousImagePath != null) {
        await deleteImage(
          deleteImagePath: previousImagePath,
          campaignCode: campaignCode,
        );
      }
      final mimeType = lookupMimeType('', headerBytes: selectedNewImage);
      final contentType = mimeType;
      final metadata = SettableMetadata(contentType: contentType);

      final extension = mimeType?.split('/').last;
      final newImagePath = extension != null
          ? 'campaigns/$campaignCode/$campaignCode.$extension'
          : '';

      if (extension != null) {
        await storage.ref(newImagePath).putData(selectedNewImage, metadata);
      }
      return [newImagePath];
    } catch (e) {
      logger.e('error uploadPicture : $e');
      rethrow;
    }
  }

  static Future<void> deleteImage({
    required String deleteImagePath,
    required String campaignCode,
  }) async {
    try {
      await storage.ref().child(deleteImagePath).delete();
    } catch (e) {
      logger.e('Error: could not delete image: $e');
    }
  }
}
