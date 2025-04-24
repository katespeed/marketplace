// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:my_flutter_app/data/mock/featured_products.dart';
// import 'package:my_flutter_app/domain/models/product.dart';

// class ProfileListings extends StatelessWidget {
//   const ProfileListings({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // mockFeaturedProductsから最初の6つの商品を取得
//     final List<Product> listings = mockFeaturedProducts.take(6).toList();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text("Listings", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             children: listings.map((product) => _buildDecoratedBox(product)).toList(),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildDecoratedBox(Product product) {
//     return Builder(
//       builder: (context) => Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: GestureDetector(
//           onTap: () {
//             GoRouter.of(context).push(
//               '/product-detail',
//               extra: product,
//             );
//           },
//           child: Container(
//             width: 150,
//             decoration: BoxDecoration(
//               color: Colors.grey[200],
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: const [
//                 BoxShadow(
//                   color: Colors.black12,
//                   blurRadius: 4,
//                   spreadRadius: 2,
//                 ),
//               ],
//             ),
//             child: Column(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(12),
//                   child: product.imageUrls.isNotEmpty == true
//                   ? Image.network(
//                     product.imageUrls[0],
//                     width: 150,
//                     height: 120,
//                     fit: BoxFit.cover,
//                     errorBuilder : (context, error, stackTrace) =>
//                       const Icon(Icons.image_not_supported),
//                   )
//                   : const Icon(Icons.image_not_supported),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(product.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
//                 Text('\$${product.price.toStringAsFixed(2)}', 
//                   style: const TextStyle(fontSize: 12, color: Colors.grey)),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
