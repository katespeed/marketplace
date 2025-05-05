import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_flutter_app/presentation/components/appbar/appbar.dart';
import 'chat_screen.dart';
import 'package:my_flutter_app/presentation/pages/user_profile_page.dart';

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
      appBar: CustomAppBar(),
      body: StreamBuilder<QuerySnapshot>(
        stream: chatsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 24),
              child: Text('Error loading chats: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;
          if (docs.isEmpty) {
            return const Center(child: Text('No chats yet'));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final chat = docs[index];
              final chatData = chat.data()! as Map<String, dynamic>;

              // ── figure out the “other” userId ───────────────────
              final participants = List<String>.from(chatData['participants']);
              final otherUserId = participants.length < 2
                  ? participants.first
                  : participants.firstWhere(
                      (id) => id != currentUserId,
                      orElse: () => participants.first,
                    );

              // ── pull the pre‑written names map out of the chat doc ─
              final namesMap = Map<String, String>.from(
                chatData['participantNames'] as Map<String, dynamic>? ?? {},
              );
              final otherUserName = namesMap[otherUserId] ?? 'Unknown';

              // ── stream that user’s reviews ────────────────────────
              return StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(otherUserId)
                    .collection('reviews')
                    .snapshots(),
                builder: (ctxReviews, reviewsSnap) {
                  final reviewDocs = reviewsSnap.data?.docs ?? [];
                  final count = reviewDocs.length;
                  final avg = count > 0
                      ? reviewDocs
                              .map((d) => (d['rating'] as num).toDouble())
                              .reduce((a, b) => a + b) /
                          count
                      : 0.0;

                  return Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue[100],
                        child: Text(
                          otherUserName.substring(0, 1).toUpperCase(),
                          style: const TextStyle(color: Colors.blue),
                        ),
                      ),
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
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      UserProfilePage(userId: otherUserId),
                                ),
                              );
                            },
                            child: Text(
                              otherUserName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Theme.of(context).primaryColor,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      subtitle: const Text(
                        'Tap to chat',
                        style: TextStyle(color: Colors.grey),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.rate_review_outlined),
                            onPressed: () =>
                                _showReviewDialog(context, otherUserId),
                          ),
                          const Icon(Icons.chevron_right, color: Colors.grey),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChatScreen(
                              chatId: chat.id,
                              sellerName: otherUserName,
                            ),
                          ),
                        );
                      },
                    ),
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
      BuildContext context, String reviewedUserId) async {
    final buyerUid = FirebaseAuth.instance.currentUser!.uid;
    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(reviewedUserId)
        .collection('reviews')
        .doc(buyerUid);

    // load existing review, if any
    final snapshot = await docRef.get();
    double rating =
        snapshot.exists ? (snapshot.data()!['rating'] as num).toDouble() : 5.0;
    String comment =
        snapshot.exists ? (snapshot.data()!['comment'] as String? ?? '') : '';

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
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
          ),
        );
      },
    );
  }
}
