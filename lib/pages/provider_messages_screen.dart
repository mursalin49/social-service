import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProviderMessagesScreen extends StatelessWidget {
  const ProviderMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final providerId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(title: const Text('Messages')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chats')
            .where('providerId', isEqualTo: providerId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Error loading messages"));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final chats = snapshot.data!.docs;

          if (chats.isEmpty) {
            return const Center(child: Text("No messages yet"));
          }

          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final data = chats[index].data() as Map<String, dynamic>;

              return ListTile(
                title: Text(data['userName'] ?? 'Unknown User'),
                subtitle: Text(data['lastMessage'] ?? ''),
                trailing: const Icon(Icons.chat),
                onTap: () {
                  // Go to full chat screen (optional)
                },
              );
            },
          );
        },
      ),
    );
  }
}
