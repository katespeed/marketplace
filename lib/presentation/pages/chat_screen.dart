import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_flutter_app/providers/chat_provider.dart';

class ChatScreen extends ConsumerWidget {
  final String chatId;
  final String sellerName;
  const ChatScreen({
    super.key,
    required this.chatId,
    required this.sellerName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messagesAsync = ref.watch(chatProvider(chatId));
    final textController = TextEditingController();
    final currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';

    void sendMessage() {
      if (textController.text.isNotEmpty) {
        ref.read(chatRepositoryProvider)
            .sendMessage(chatId: chatId, text: textController.text);
        textController.clear();
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(sellerName)),
      body: Column(
        children: [
          Expanded(
            child: messagesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Text('Error: $err'),
              data: (msgs) => ListView.builder(
                reverse: false,
                itemCount: msgs.size,
                itemBuilder: (_, i) {
                  final msg = msgs.docs[i].data() as Map<String, dynamic>? ?? {};
                  final isMe = msg['sender'] == currentUserId;

                  return Align(
                    alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isMe ? Colors.blue : Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        msg['text']?.toString() ?? '',
                        style: TextStyle(
                          color: isMe ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => sendMessage(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}