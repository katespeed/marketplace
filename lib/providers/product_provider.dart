import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:my_flutter_app/domain/models/product.dart'; 


/// **Create a FutureProvider to fetch products**
final productListProvider = FutureProvider<List<Product>>((ref) async {
  final snapshot = await FirebaseFirestore.instance.collection('products').get();

  return snapshot.docs.map((doc) {
    final data = doc.data();
    return Product.fromJson({
      ...data,
      'id': doc.id,
      'name': data['title'],
      'imageUrls': data['imageUrls'] ?? <String>[],

   });
  }).toList();
});