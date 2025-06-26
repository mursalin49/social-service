// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
//
// class ChatScreen extends StatefulWidget {
//   final String receiverId;
//   final String receiverName;
//
//   const ChatScreen({
//     Key? key,
//     required this.receiverId,
//     required this.receiverName,
//   }) : super(key: key);
//
//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _messageController = TextEditingController();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
//
//   late String chatId;
//   late String currentUserId;
//
//   @override
//   void initState() {
//     super.initState();
//     currentUserId = _auth.currentUser!.uid;
//     chatId = currentUserId.compareTo(widget.receiverId) < 0
//         ? '${currentUserId}_${widget.receiverId}'
//         : '${widget.receiverId}_${currentUserId}';
//   }
//
//   void sendMessage() async {
//     String message = _messageController.text.trim();
//     if (message.isEmpty) return;
//
//     final timestamp = DateTime.now().millisecondsSinceEpoch;
//     final newMsgRef = _dbRef.child('chats').child(chatId).push();
//
//     await newMsgRef.set({
//       'senderId': currentUserId,
//       'text': message,
//       'timestamp': timestamp,
//       'seen': false,
//     });
//
//     _messageController.clear();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.receiverName)),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder(
//               stream: _dbRef
//                   .child('chats')
//                   .child(chatId)
//                   .orderByChild('timestamp')
//                   .onValue,
//               builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
//                 if (!snapshot.hasData ||
//                     snapshot.data!.snapshot.value == null) {
//                   return const Center(child: Text('No messages yet'));
//                 }
//
//                 Map<dynamic, dynamic> messagesMap =
//                     snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
//
//                 List<Map<dynamic, dynamic>> messagesList = messagesMap.entries
//                     .map((e) => e.value as Map<dynamic, dynamic>)
//                     .toList();
//
//                 messagesList
//                     .sort((a, b) => a['timestamp'].compareTo(b['timestamp']));
//
//                 return ListView.builder(
//                   reverse: true,
//                   itemCount: messagesList.length,
//                   itemBuilder: (context, index) {
//                     final msg = messagesList[messagesList.length - 1 - index];
//                     bool isMe = msg['senderId'] == currentUserId;
//
//                     return Align(
//                       alignment:
//                           isMe ? Alignment.centerRight : Alignment.centerLeft,
//                       child: Container(
//                         margin: const EdgeInsets.symmetric(
//                             vertical: 4, horizontal: 8),
//                         padding: const EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color:
//                               isMe ? Colors.blueAccent : Colors.grey.shade300,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Text(
//                           msg['text'],
//                           style: TextStyle(
//                               color: isMe ? Colors.white : Colors.black87),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _messageController,
//                     decoration: const InputDecoration(
//                       hintText: "Type a message",
//                       border: OutlineInputBorder(),
//                     ),
//                     onSubmitted: (_) => sendMessage(),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 IconButton(
//                   icon: const Icon(Icons.send),
//                   onPressed: sendMessage,
//                   color: Colors.blueAccent,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class ChatScreen extends StatefulWidget {
  final String receiverId;
  final String receiverName;

  const ChatScreen({
    Key? key,
    required this.receiverId,
    required this.receiverName,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  late String chatId;
  late String currentUserId;

  @override
  void initState() {
    super.initState();
    currentUserId = _auth.currentUser!.uid;

    chatId = currentUserId.compareTo(widget.receiverId) < 0
        ? '${currentUserId}_${widget.receiverId}'
        : '${widget.receiverId}_${currentUserId}';
  }

  void sendMessage() async {
    String message = _messageController.text.trim();
    if (message.isEmpty) return;

    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final newMsgRef = _dbRef.child('messages').child(chatId).push();

    await newMsgRef.set({
      'senderId': currentUserId,
      'text': message,
      'timestamp': timestamp,
      'seen': false,
    });

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.receiverName)),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _dbRef
                  .child('messages')
                  .child(chatId)
                  .orderByChild('timestamp')
                  .onValue,
              builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                if (!snapshot.hasData ||
                    snapshot.data!.snapshot.value == null) {
                  return const Center(child: Text('No messages yet'));
                }

                Map<dynamic, dynamic> messagesMap =
                    snapshot.data!.snapshot.value as Map<dynamic, dynamic>;

                List<dynamic> messagesList = messagesMap.entries
                    .map((e) => e.value as Map<dynamic, dynamic>)
                    .toList();

                messagesList
                    .sort((a, b) => a['timestamp'].compareTo(b['timestamp']));

                return ListView.builder(
                  reverse: true,
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) {
                    final msg = messagesList[messagesList.length - 1 - index];
                    bool isMe = msg['senderId'] == currentUserId;

                    return Align(
                      alignment:
                          isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color:
                              isMe ? Colors.blueAccent : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          msg['text'],
                          style: TextStyle(
                              color: isMe ? Colors.white : Colors.black87),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: "Type a message",
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: sendMessage,
                  color: Colors.blueAccent,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
