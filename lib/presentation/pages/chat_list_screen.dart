import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chat_screen.dart';

class ChatListScreen extends ConsumerWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    final chatsStream = FirebaseFirestore.instance
        .collection('chats')
        .where('participants', arrayContains: currentUserId)
        .snapshots();

    return Scaffold(
      appBar: AppBar(title: const Text('Messages')),
      body: StreamBuilder<QuerySnapshot>(
        stream: chatsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          if (!snapshot.hasData) return const CircularProgressIndicator();

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final chat = snapshot.data!.docs[index];
              // new defensive participants logic ↓
              final participants = List<String>.from(chat['participants']);
              String otherUserId;
              if (participants.length < 2) {
                // fallback if something went wrong
                otherUserId = participants.first;
              } else {
                otherUserId = participants.firstWhere(
                  (id) => id != currentUserId,
                  orElse: () => participants.first,
                );
              }

              // 1) load the other user’s basic info once
              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(otherUserId)
                    .get(),
                builder: (ctxUser, userSnap) {
                  final userData =
                      userSnap.data?.data() as Map<String, dynamic>?;
                  final sellerName = userData?['name'] ?? 'Loading…';

                  // 2) stream their reviews
                  return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(otherUserId)
                        .collection('reviews')
                        .snapshots(),
                    builder: (ctxReviews, reviewsSnap) {
                      final docs = reviewsSnap.data?.docs ?? [];
                      final count = docs.length;
                      final avg = count > 0
                          ? docs
                                  .map((d) => (d['rating'] as num).toDouble())
                                  .reduce((a, b) => a + b) /
                              count
                          : 0.0;

                      return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue[100],
                            child: Text(
                              sellerName.substring(0, 1).toUpperCase(),
                              style: const TextStyle(color: Colors.blue),
                            ),
                          ),

                          // — 3) Display the star + count above the name —
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.star,
                                      size: 14, color: Colors.amber),
                                  const SizedBox(width: 4),
                                  Text(
                                    count == 0
                                        ? 'No reviews'
                                        : '${avg.toStringAsFixed(1)} ($count)',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                sellerName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),

                          subtitle: const Text(
                            'Tap to chat',
                            style: TextStyle(color: Colors.grey),
                          ),

                          // — 4) Add review button plus chevron —
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.rate_review_outlined),
                                onPressed: () =>
                                    _showReviewDialog(context, otherUserId),
                              ),
                              const Icon(Icons.chevron_right,
                                  color: Colors.grey),
                            ],
                          ),

                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChatScreen(
                                chatId: chat.id,
                                sellerName: sellerName,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _showReviewDialog(
    BuildContext context,
    String reviewedUserId,
  ) async {
    final buyerUid = FirebaseAuth.instance.currentUser!.uid;
    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(reviewedUserId)
        .collection('reviews')
        .doc(buyerUid);

    // 1) load existing (if any)
    final snapshot = await docRef.get();
    double rating =
        snapshot.exists ? (snapshot.data()!['rating'] as num).toDouble() : 5.0;
    String comment =
        snapshot.exists ? (snapshot.data()!['comment'] as String? ?? '') : '';

    // 2) show the same StatefulBuilder dialog
    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title:
                Text(snapshot.exists ? 'Edit your review' : 'Leave a review'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Slider(
                  value: rating,
                  min: 1,
                  max: 5,
                  divisions: 4,
                  label: rating.toStringAsFixed(0),
                  onChanged: (v) => setState(() => rating = v),
                ),
                TextField(
                  controller: TextEditingController(text: comment),
                  decoration:
                      const InputDecoration(labelText: 'Comment (optional)'),
                  onChanged: (t) => comment = t,
                ),
              ],
            ),
            actions: [
              TextButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.pop(context),
              ),
              ElevatedButton(
                child: const Text('Submit'),
                onPressed: () {
                  // 3) write with set() to create or overwrite
                  docRef.set({
                    'reviewerId': buyerUid,
                    'rating': rating,
                    'comment': comment,
                    'createdAt': FieldValue.serverTimestamp(),
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
