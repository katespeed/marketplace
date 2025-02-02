import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_flutter_app/providers/uploaded_items_provider.dart';

class ProductListPage extends ConsumerWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uploadedItems = ref.watch(uploadedItemsProvider);

    // Predefined product list
    final List<Map<String, dynamic>> predefinedProducts = [
      {
        'name': 'Laptop',
        'description': 'Brand new laptop for sale.',
        'price': '\$500',
        'image':
            'assets/laptop.png', // Ensure these assets exist in pubspec.yaml
      },
      {
        'name': 'Bike',
        'description': 'Bicycle for rent.',
        'price': '\$20/day',
        'image': 'assets/bike.png',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Product List")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Available Products",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Display Predefined Products
            ...predefinedProducts
                .map((product) => ProductCard(product))
                .toList(),

            const SizedBox(height: 20),

            const Text(
              "Your Listed Items",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            uploadedItems.isEmpty
                ? const Text("No items uploaded yet.",
                    style: TextStyle(fontSize: 16))
                : Column(
                    children:
                        uploadedItems.map((item) => ProductCard(item)).toList(),
                  ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> item;
  const ProductCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: item['images'] != null && item['images'].isNotEmpty
            ? (kIsWeb
                ? Image.memory(item['images'][0],
                    width: 50, height: 50, fit: BoxFit.cover)
                : Image.asset(item['images'][0],
                    width: 50, height: 50, fit: BoxFit.cover))
            : const Icon(Icons.image_not_supported, size: 50),
        title: Text(item['name'] ?? 'Unnamed Item',
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item['description'] ?? "No description available."),
            Text("Price: ${item['price'] ?? 'Not specified'}"),
          ],
        ),
      ),
    );
  }
}
