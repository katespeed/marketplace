import 'package:flutter_riverpod/flutter_riverpod.dart';

final uploadedItemsProvider =
    StateNotifierProvider<UploadedItemsNotifier, List<Map<String, dynamic>>>(
  (ref) => UploadedItemsNotifier(),
);

class UploadedItemsNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  UploadedItemsNotifier() : super([]);

  void addItem(Map<String, dynamic> item) {
    state = [...state, item]; // Add new item to the list
  }
}
