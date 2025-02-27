import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_flutter_app/data/firebase_strage/storage_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'storage_service.g.dart';

/// キャンペーンのサービスProvider
@Riverpod(keepAlive: true)
StorageService storageService(StorageServiceRef ref) {
  return StorageService(ref);
}

/// キャンペーンのサービス
class StorageService {
  /// initializer
  StorageService(this.ref);

  /// ref
  final Ref ref;

  /// キャンペーンリポジトリ
  StorageRepository get storageRepository =>
      ref.read(storageRepositoryProvider);

  /// firestore Storage
  static final storage = FirebaseStorage.instance;

  /// 画像をダウンロードする
  static Future<Image?> downloadImage(String downloadImagePath) async {
    return StorageRepository.downloadImage(downloadImagePath);
  }

  /// 画像をアップロードしてパスを返す
  static Future<List<String>> uploadImage({
    required Uint8List selectedNewImage,
    required String campaignCode,
    String? previousImagePath,
    String? selectedImageName,
  }) async {
    return StorageRepository.uploadImage(
      selectedNewImage: selectedNewImage,
      campaignCode: campaignCode,
      previousImagePath: previousImagePath,
      selectedImageName: selectedImageName,
    );
  }

  /// 画像を削除する
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
