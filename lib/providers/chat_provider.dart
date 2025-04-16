import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/chat/chat_repository.dart';

final chatRepositoryProvider = Provider((ref) => ChatRepository());

final chatProvider = StreamProvider.family<QuerySnapshot, String>(
      (ref, chatId) => ref.read(chatRepositoryProvider).getMessages(chatId),
);