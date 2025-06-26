import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'ChatScreen.dart';

class RecentChatsScreen extends StatefulWidget {
  const RecentChatsScreen({Key? key}) : super(key: key);

  @override
  State<RecentChatsScreen> createState() => _RecentChatsScreenState();
}

class _RecentChatsScreenState extends State<RecentChatsScreen> {
  final _auth = FirebaseAuth.instance;
  final _dbRef = FirebaseDatabase.instance.ref();
  late String currentUserId;

  Map<String, Map<String, dynamic>> chats =
      {}; // chatId -> latestMessage + info

  @override
  void initState() {
    super.initState();
    currentUserId = _auth.currentUser!.uid;
    _listenToChats();
  }

  void _listenToChats() {
    _dbRef.child('chats').onValue.listen((event) {
      if (event.snapshot.value == null) return;

      Map<dynamic, dynamic> allChats =
          event.snapshot.value as Map<dynamic, dynamic>;
      Map<String, Map<String, dynamic>> filteredChats = {};

      allChats.forEach((chatId, messagesMap) {
        if (chatId.toString().contains(currentUserId)) {
          // chatId এ আমাদের userId আছে মানে আমাদের চ্যাট

          // messagesMap একটি ম্যাপ, যার ভ্যালু গুলো মেসেজ অবজেক্ট
          Map<dynamic, dynamic> msgs = Map<dynamic, dynamic>.from(messagesMap);

          // সর্বশেষ মেসেজ খুঁজে বের করা
          var lastMsgEntry = msgs.entries.reduce(
              (a, b) => a.value['timestamp'] > b.value['timestamp'] ? a : b);
          Map<String, dynamic> lastMsg =
              Map<String, dynamic>.from(lastMsgEntry.value);

          filteredChats[chatId.toString()] = {
            "lastMessage": lastMsg['text'],
            "timestamp": lastMsg['timestamp'],
            "senderId": lastMsg['senderId'],
            "seen": lastMsg['seen'] ?? false,
          };
        }
      });

      setState(() {
        chats = filteredChats;
      });
    });
  }

  Future<String> _getChatPartnerName(String chatId) async {
    // chatId থেকে অপর ব্যক্তির uid বের করব
    List<String> parts = chatId.split('_');
    String partnerId = parts[0] == currentUserId ? parts[1] : parts[0];

    final snapshot =
        await _dbRef.child('users').child(partnerId).child('name').get();
    return snapshot.exists ? snapshot.value.toString() : "Unknown";
  }

  @override
  Widget build(BuildContext context) {
    var chatList = chats.entries.toList()
      ..sort((a, b) => b.value['timestamp']
          .compareTo(a.value['timestamp'])); // নতুন থেকে পুরাতন

    return Scaffold(
      appBar: AppBar(title: const Text("Recent Chats")),
      body: chatList.isEmpty
          ? const Center(child: Text("No chats yet"))
          : ListView.builder(
              itemCount: chatList.length,
              itemBuilder: (context, index) {
                final chatId = chatList[index].key;
                final lastMsg = chatList[index].value['lastMessage'];
                final timestamp = chatList[index].value['timestamp'];
                final senderId = chatList[index].value['senderId'];
                final seen = chatList[index].value['seen'] as bool;

                return FutureBuilder<String>(
                  future: _getChatPartnerName(chatId),
                  builder: (context, snapshot) {
                    String partnerName = snapshot.data ?? "Loading...";

                    bool isUnread = !seen && senderId != currentUserId;

                    return ListTile(
                      title: Text(
                        partnerName,
                        style: TextStyle(
                          fontWeight:
                              isUnread ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      subtitle: Text(
                        lastMsg,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight:
                              isUnread ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      trailing: isUnread
                          ? Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                "New",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            )
                          : null,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChatScreen(
                              receiverId: chatId.split('_')[0] == currentUserId
                                  ? chatId.split('_')[1]
                                  : chatId.split('_')[0],
                              receiverName: partnerName,
                            ),
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
}
