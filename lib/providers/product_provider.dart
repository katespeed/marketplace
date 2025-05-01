import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_flutter_app/domain/models/product.dart'; 

// Add a refresh trigger provider
final refreshTriggerProvider = StateProvider<int>((ref) => 0);

/// **Create a StreamProvider to fetch products**
final productListProvider = StreamProvider<List<Product>>((ref) {
  // Watch the refresh trigger to force a refresh
  ref.watch(refreshTriggerProvider);
  
  return FirebaseFirestore.instance
      .collection('products')
      .where('isAvailable', isEqualTo: true)
      .snapshots()
      .asyncMap((snapshot) async {
        final products = await Future.wait(snapshot.docs.map((doc) async {
          final data = doc.data();
          final sellerId = data['sellerId'] as String?;
          
          // Get seller's profile image path
          String? sellerImageUrl;
          String? sellerName;
          if (sellerId != null) {
            final sellerDoc = await FirebaseFirestore.instance
                .collection('users')
                .doc(sellerId)
                .get();
            final sellerData = sellerDoc.data();
            sellerImageUrl = sellerData?['profileImagePath'] as String?;
            sellerName = sellerData?['name'] as String?;
          }

          return Product.fromJson({
            ...data,
            'id': doc.id,
            'name': data['title'] ?? data['name'] ?? '',
            'price': (data['price'] as num?)?.toDouble() ?? 0.0,
            'imageUrls': List<String>.from(data['imageUrls'] ?? []),
            'description': data['description'] ?? '',
            'sellerId': sellerId,
            'sellerImageUrl': sellerImageUrl,
            'sellerName': sellerName,
            'isAvailable': data['isAvailable'] ?? true,
            'createdAt': data['createdAt']?.toDate().toIso8601String(),
          });
        }));

        return products;
      });
});

/// **Create a StreamProvider to fetch products by seller ID**
final sellerProductsProvider = StreamProvider.family<List<Product>, String>((ref, sellerId) {
  ref.watch(refreshTriggerProvider);
  
  return FirebaseFirestore.instance
      .collection('products')
      .where('sellerId', isEqualTo: sellerId)
      .where('isAvailable', isEqualTo: true)
      .snapshots()
      .asyncMap((snapshot) async {
        // Get seller's profile image path
        final sellerDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(sellerId)
            .get();
        final sellerData = sellerDoc.data();
        final sellerImageUrl = sellerData?['profileImagePath'] as String?;
        final sellerName = sellerData?['name'] as String?;

        return snapshot.docs.map((doc) {
          final data = doc.data();
          return Product.fromJson({
            ...data,
            'id': doc.id,
            'name': data['title'] ?? data['name'] ?? '',
            'price': (data['price'] as num?)?.toDouble() ?? 0.0,
            'imageUrls': List<String>.from(data['imageUrls'] ?? []),
            'description': data['description'] ?? '',
            'sellerId': sellerId,
            'sellerImageUrl': sellerImageUrl,
            'sellerName': sellerName,
            'isAvailable': data['isAvailable'] ?? true,
            'createdAt': data['createdAt']?.toDate().toIso8601String(),
          });
        }).toList();
      });
});

/// **Create a StateProvider for search query**
final searchQueryProvider = StateProvider<String>((ref) => '');

/// **Create a Provider for filtered products**
final filteredProductsProvider = Provider<List<Product>>((ref) {
  final searchQuery = ref.watch(searchQueryProvider);
  final products = ref.watch(productListProvider).value ?? [];

  if (searchQuery.isEmpty) {
    return products;
  }

  return products.where((product) {
    final nameMatch = product.name.toLowerCase().contains(searchQuery.toLowerCase());
    final descriptionMatch = product.description?.toLowerCase().contains(searchQuery.toLowerCase()) ?? false;
    return nameMatch || descriptionMatch;
  }).toList();
});