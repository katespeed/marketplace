import 'package:flutter/material.dart';

class ProfileSales extends StatelessWidget {
  final List<Map<String, String>> sales = [
    {'name': 'Nike Air Max', 'image': 'assets/products/nike_air_max.jpeg', 'date': 'Feb 23, 2023', 'price': '\$120'},
    {'name': 'Samsung TV', 'image': 'assets/products/samsung_tv.jpeg', 'date': 'Mar 1, 2023', 'price': '\$500'},
    {'name': 'Speaker', 'image': 'assets/products/speaker.jpeg', 'date': 'Mar 3, 2023', 'price': '\$80'},
    {'name': 'Watch', 'image': 'assets/products/watch.jpeg', 'date': 'Mar 5, 2023', 'price': '\$150'},
  ];

  ProfileSales({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Sales", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Column(
          children: sales.map((sale) => _buildSalesItem(sale)).toList(),
        ),
      ],
    );
  }

  Widget _buildSalesItem(Map<String, String> sale) {
    return ListTile(
      leading: Image.asset(sale['image']!, width: 50, height: 50, fit: BoxFit.cover),
      title: Text(sale['name']!),
      subtitle: Text(sale['date']!),
      trailing: Text(sale['price']!, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
    );
  }
}
