import 'package:flutter/material.dart';

import 'message.dart';

class MessageList extends StatelessWidget {
  final List<Message> messages;
  final String currentUserId;

  const MessageList({
    Key? key,
    required this.messages,
    required this.currentUserId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        final isMe = message.senderId == currentUserId;

        return Align(
          alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              color: isMe ? Colors.blue : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              message.text,
              style: TextStyle(color: isMe ? Colors.white : Colors.black87),
            ),
          ),
        );
      },
    );
  }
}
