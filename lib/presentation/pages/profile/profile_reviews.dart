import 'package:flutter/material.dart';

class ProfileReviews extends StatelessWidget {
  final List<Map<String, String>> reviews = [
    {'rating': '5 stars', 'comment': 'Great seller! Love the camera!', 'date': 'Mar 1, 2023'},
    {'rating': '5 stars', 'comment': 'Fast shipping and great condition. Thanks!', 'date': 'Feb 24, 2023'},
    {'rating': '5 stars', 'comment': 'Item as described. Fast shipping. Great seller!', 'date': 'Feb 19, 2023'},
  ];

  ProfileReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Reviews", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Column(
          children: reviews.map((review) => _buildReviewItem(review)).toList(),
        ),
      ],
    );
  }

  Widget _buildReviewItem(Map<String, String> review) {
    return ListTile(
      leading: const Icon(Icons.star, color: Colors.yellow),
      title: Text(review['rating']!),
      subtitle: Text(review['comment']!),
      trailing: Text(review['date']!, style: const TextStyle(color: Colors.grey)),
    );
  }
}
