import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Product {
  final String title;
  final String price;
  final String description;
  final Uint8List image;

  Product({
    required this.title,
    required this.price,
    required this.description,
    required this.image,
  });
}

final productListProvider = StateNotifierProvider<ProductListNotifier, List<Product>>((ref) {
  return ProductListNotifier();
});

class ProductListNotifier extends StateNotifier<List<Product>> {
  ProductListNotifier() : super([]);

  void addProduct(Product product) {
    state = List.unmodifiable([...state, product]); // Ensures immutability
  }

  void removeProduct(int index) {
    if (index >= 0 && index < state.length) {
      state = List.unmodifiable([...state]..removeAt(index));
    }
  }

  void clearProducts() {
    state = [];
  }
}
