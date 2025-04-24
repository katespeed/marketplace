import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_flutter_app/domain/models/product.dart'; 

// Add a refresh trigger provider
final refreshTriggerProvider = StateProvider<int>((ref) => 0);

/// **Create a FutureProvider to fetch products**
final productListProvider = FutureProvider<List<Product>>((ref) async {
  // Watch the refresh trigger to force a refresh
  ref.watch(refreshTriggerProvider);
  
  try {
    final snapshot = await FirebaseFirestore.instance
        .collection('products')
        .where('isAvailable', isEqualTo: true)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return Product.fromJson({
        ...data,
        'id': doc.id,
        'name': data['title'] ?? data['name'] ?? '',
        'price': (data['price'] as num?)?.toDouble() ?? 0.0,
        'imageUrls': List<String>.from(data['imageUrls'] ?? []),
        'description': data['description'] ?? '',
        'sellerId': data['sellerId'] ?? '',
        'isAvailable': data['isAvailable'] ?? true,
        'createdAt': data['createdAt']?.toDate().toIso8601String(),
      });
    }).toList();
  } catch (e) {
    throw Exception('Failed to fetch products: $e');
  }
});

/// **Create a FutureProvider to fetch products by seller ID**
final sellerProductsProvider = FutureProvider.family<List<Product>, String>((ref, sellerId) async {
  ref.watch(refreshTriggerProvider);
  
  try {
    final snapshot = await FirebaseFirestore.instance
        .collection('products')
        .where('sellerId', isEqualTo: sellerId)
        .where('isAvailable', isEqualTo: true)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return Product.fromJson({
        ...data,
        'id': doc.id,
        'name': data['title'] ?? data['name'] ?? '',
        'price': (data['price'] as num?)?.toDouble() ?? 0.0,
        'imageUrls': List<String>.from(data['imageUrls'] ?? []),
        'description': data['description'] ?? '',
        'sellerId': data['sellerId'] ?? '',
        'isAvailable': data['isAvailable'] ?? true,
        'createdAt': data['createdAt']?.toDate().toIso8601String(),
      });
    }).toList();
  } catch (e) {
    throw Exception('Failed to fetch seller products: $e');
  }
});