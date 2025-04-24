import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> getImageUrl(String path) async {
    try {
      final ref = _storage.ref().child(path);
      return await ref.getDownloadURL();
    } catch (e) {
      debugPrint('Error getting image URL: $e');
      rethrow;
    }
  }

  Future<List<String>> getImageUrls(List<String> paths) async {
    try {
      final urls = <String>[];
      for (final path in paths) {
        final url = await getImageUrl(path);
        urls.add(url);
      }
      return urls;
    } catch (e) {
      debugPrint('Error getting image URLs: $e');
      rethrow;
    }
  }
} 