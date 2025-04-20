import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ProfileReviews extends StatelessWidget {
  final String userId;
  const ProfileReviews({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Reviews',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .collection('reviews')
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (context, snap) {
            if (snap.hasError) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Text('Error loading reviews'),
              );
            }
            if (!snap.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final docs = snap.data!.docs;
            if (docs.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(8),
                child: Text('No reviews yet'),
              );
            }

            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (_, __) => const Divider(),
              itemCount: docs.length,
              itemBuilder: (context, i) {
                final data = docs[i].data()! as Map<String, dynamic>;
                final rating = (data['rating'] as num).toDouble();
                final comment = data['comment'] as String? ?? '';
                final ts = data['createdAt'] as Timestamp?;
                final date =
                    ts != null ? DateFormat.yMMMd().format(ts.toDate()) : '';

                return ListTile(
                  leading: const Icon(Icons.star, color: Colors.yellow),
                  title: Text('${rating.toStringAsFixed(0)} stars'),
                  subtitle: Text(comment),
                  trailing: Text(date,
                      style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
