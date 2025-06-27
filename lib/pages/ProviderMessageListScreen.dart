import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'ChatScreen.dart';

class ProviderMessageListScreen extends StatefulWidget {
  const ProviderMessageListScreen({super.key});

  @override
  State<ProviderMessageListScreen> createState() =>
      _ProviderMessageListScreenState();
}

class _ProviderMessageListScreenState extends State<ProviderMessageListScreen> {
  final currentUser = FirebaseAuth.instance.currentUser;
  final dbRef = FirebaseDatabase.instance.ref().child("messages");

  List<Map<String, dynamic>> chatList = [];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _loadMessages() async {
    final snapshot = await dbRef.get();
    List<Map<String, dynamic>> tempList = [];

    if (snapshot.exists) {
      final data = snapshot.value as Map<dynamic, dynamic>;
      data.forEach((chatId, messages) {
        if (chatId.contains(currentUser?.uid)) {
          final ids = chatId.toString().split("_");
          final otherUserId = ids[0] == currentUser?.uid ? ids[1] : ids[0];
          tempList.add({
            "chatId": chatId,
            "otherUserId": otherUserId,
          });
        }
      });

      setState(() {
        chatList = tempList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Messages from Users")),
      body: chatList.isEmpty
          ? const Center(child: Text("No messages yet."))
          : ListView.builder(
              itemCount: chatList.length,
              itemBuilder: (context, index) {
                final chat = chatList[index];
                return ListTile(
                  leading: const Icon(Icons.person),
                  title: Text("User ID: ${chat["otherUserId"]}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.chat),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChatScreen(
                            receiverId: chat["otherUserId"],
                            receiverName: "User",
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
