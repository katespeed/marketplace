import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_flutter_app/data/firebase_strage/storage_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'storage_service.g.dart';

@Riverpod(keepAlive: true)
StorageService storageService(StorageServiceRef ref) {
  return StorageService(ref);
}

class StorageService {
  StorageService(this.ref);

  final Ref ref;

  StorageRepository get storageRepository =>
      ref.read(storageRepositoryProvider);

  static final storage = FirebaseStorage.instance;

  static Future<Image?> downloadImage(String downloadImagePath) async {
    return StorageRepository.downloadImage(downloadImagePath);
  }

  static Future<void> deleteImage({
    required String deleteImagePath,
    required String campaignCode,
  }) async {
    return StorageRepository.deleteImage(
      deleteImagePath: deleteImagePath,
      campaignCode: campaignCode,
    );
  }
}
