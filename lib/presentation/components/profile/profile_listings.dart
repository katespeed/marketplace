import 'package:flutter/material.dart';

class ProfileListings extends StatelessWidget {
  final List<Map<String, String>> listings = const [
    {'name': 'Canon Camera', 'image': 'assets/products/canon_camera.jpeg'},
    {'name': 'Dyson Vacuum', 'image': 'assets/products/dyson_vacuum.jpeg'},
    {'name': 'Ikea Desk', 'image': 'assets/products/ikea_desk.jpeg'},
    {'name': 'iPhone 13', 'image': 'assets/products/iphone_13.jpeg'},
    {'name': 'Laptop', 'image': 'assets/products/laptop.jpeg'},
    {'name': 'MacBook Pro', 'image': 'assets/products/macbook_pro.jpeg'},
  ];

  const ProfileListings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Listings", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: listings.map((item) => _buildDecoratedBox(item)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildDecoratedBox(Map<String, String> item) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(item['image']!, width: 150, height: 120, fit: BoxFit.cover),
            ),
            const SizedBox(height: 4),
            Text(item['name']!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
