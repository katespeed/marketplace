import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/chat_provider.dart';
import '../../pages/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatButton extends ConsumerWidget {
  final String sellerId;
  const ChatButton({super.key, required this.sellerId});

  Future<String> _fetchSellerName() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(sellerId)
          .get();
      return doc.data()?['name'] ?? 'Seller';
    } catch (e) {
      return 'Seller';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () async {
        final buyer = FirebaseAuth.instance.currentUser!;
        final buyerName = buyer.displayName ?? buyer.email!;
        final sellerName = await _fetchSellerName();
        final chatId =
            await ref.read(chatRepositoryProvider).getOrCreateChat(sellerId);
        // 4) write both names into the chat doc (merge so we don’t clobber other fields)
        await FirebaseFirestore.instance.collection('chats').doc(chatId).set({
          'participantNames': {
            sellerId: sellerName,
            buyer.uid: buyerName,
          },
        }, SetOptions(merge: true));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChatScreen(
              chatId: chatId,
              sellerName: sellerName,
            ),
          ),
        );
      },
      child: const Text('Chat with Seller'),
    );
  }
}
