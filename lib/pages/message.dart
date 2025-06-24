import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ChatScreen.dart';

class MessagePage extends StatelessWidget {
  final String currentUserId = "abc123";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
        backgroundColor: Color.fromRGBO(49, 39, 79, 1),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('providers').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final providers = snapshot.data!.docs;
          if (providers.isEmpty) {
            return Center(child: Text("No providers available"));
          }
          return ListView.builder(
            itemCount: providers.length,
            itemBuilder: (context, index) {
              final provider = providers[index];
              final chatId = getChatId(currentUserId, provider.id);
              return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('chats')
                    .doc(chatId)
                    .collection('messages')
                    .orderBy('timestamp', descending: true)
                    .limit(1)
                    .snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> messageSnapshot) {
                  String lastMessage = "No messages yet";
                  String lastMessageTime = "";
                  if (messageSnapshot.hasData &&
                      messageSnapshot.data!.docs.isNotEmpty) {
                    final lastMsg = messageSnapshot.data!.docs.first;
                    lastMessage = lastMsg['text'];
                    final timestamp =
                        (lastMsg['timestamp'] as Timestamp?)?.toDate();
                    lastMessageTime = timestamp != null
                        ? "${timestamp.hour}:${timestamp.minute}"
                        : "";
                  }
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(provider['image'] ??
                          'https://via.placeholder.com/150'),
                      radius: 20,
                    ),
                    title: Text(provider['name']),
                    subtitle: Text(lastMessage),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.message),
                        SizedBox(height: 4),
                        Text(lastMessageTime, style: TextStyle(fontSize: 10)),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            chatId: chatId,
                            userId: currentUserId,
                            providerId: provider.id,
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

  String getChatId(String user1, String user2) {
    return user1.hashCode <= user2.hashCode
        ? '${user1}_$user2'
        : '${user2}_$user1';
  }
}
