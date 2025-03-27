import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Product Model
class Product {
  final String id;
  final String title;
  final double price;
  final String description;
  final String sellerId;
  final String? sellerPayPalEmail;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.sellerId,
    this.sellerPayPalEmail,
  });

  /// Convert Firestore document to Product object
  factory Product.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Product(
      id: doc.id,
      title: data['title'],
      price: (data['price'] as num).toDouble(),
      description: data['description'],
      sellerId: data['sellerId'],
      sellerPayPalEmail: data['sellerPayPal'] ?? "Not Available",
    );
  }
}

/// **Create a FutureProvider to fetch products**
final productListProvider = FutureProvider<List<Product>>((ref) async {
  final snapshot =
      await FirebaseFirestore.instance.collection('products').get();
  return snapshot.docs.map((doc) => Product.fromFirestore(doc)).toList();
});
