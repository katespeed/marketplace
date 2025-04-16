import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Generate a consistent chat ID for any two users
  String _getChatId(String user1, String user2) {
    final ids = [user1, user2]..sort();
    return ids.join('_');
  }

  // Create or fetch a chat between current user and seller
  Future<String> getOrCreateChat(String sellerId) async {
    final buyerId = FirebaseAuth.instance.currentUser!.uid;
    final chatId = _getChatId(buyerId, sellerId);
    final chatDoc = _firestore.collection('chats').doc(chatId);

    if (!(await chatDoc.get()).exists) {
      await chatDoc.set({
        'participants': [buyerId, sellerId],
        'createdAt': Timestamp.now(),
      });
    }
    return chatId;
  }

  // Stream messages for a chat
  Stream<QuerySnapshot> getMessages(String chatId) {
    return _firestore.collection('chats').doc(chatId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots();
  }

  // Send a message
  Future<void> sendMessage({
    required String chatId,
    required String text,
  }) async {
    await _firestore.collection('chats').doc(chatId)
        .collection('messages')
        .add({
      'text': text,
      'sender': FirebaseAuth.instance.currentUser!.uid,
      'timestamp': Timestamp.now(),
    });
  }
}