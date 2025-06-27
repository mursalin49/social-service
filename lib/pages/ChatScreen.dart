// // import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:firebase_database/firebase_database.dart';
// //
// // class ChatScreen extends StatefulWidget {
// //   final String receiverId;
// //   final String receiverName;
// //
// //   const ChatScreen({
// //     Key? key,
// //     required this.receiverId,
// //     required this.receiverName,
// //   }) : super(key: key);
// //
// //   @override
// //   State<ChatScreen> createState() => _ChatScreenState();
// // }
// //
// // class _ChatScreenState extends State<ChatScreen> {
// //   final TextEditingController _messageController = TextEditingController();
// //   final FirebaseAuth _auth = FirebaseAuth.instance;
// //   final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
// //
// //   late String chatId;
// //   late String currentUserId;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     currentUserId = _auth.currentUser!.uid;
// //     chatId = currentUserId.compareTo(widget.receiverId) < 0
// //         ? '${currentUserId}_${widget.receiverId}'
// //         : '${widget.receiverId}_${currentUserId}';
// //   }
// //
// //   void sendMessage() async {
// //     String message = _messageController.text.trim();
// //     if (message.isEmpty) return;
// //
// //     final timestamp = DateTime.now().millisecondsSinceEpoch;
// //     final newMsgRef = _dbRef.child('chats').child(chatId).push();
// //
// //     await newMsgRef.set({
// //       'senderId': currentUserId,
// //       'text': message,
// //       'timestamp': timestamp,
// //       'seen': false,
// //     });
// //
// //     _messageController.clear();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text(widget.receiverName)),
// //       body: Column(
// //         children: [
// //           Expanded(
// //             child: StreamBuilder(
// //               stream: _dbRef
// //                   .child('chats')
// //                   .child(chatId)
// //                   .orderByChild('timestamp')
// //                   .onValue,
// //               builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
// //                 if (!snapshot.hasData ||
// //                     snapshot.data!.snapshot.value == null) {
// //                   return const Center(child: Text('No messages yet'));
// //                 }
// //
// //                 Map<dynamic, dynamic> messagesMap =
// //                     snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
// //
// //                 List<Map<dynamic, dynamic>> messagesList = messagesMap.entries
// //                     .map((e) => e.value as Map<dynamic, dynamic>)
// //                     .toList();
// //
// //                 messagesList
// //                     .sort((a, b) => a['timestamp'].compareTo(b['timestamp']));
// //
// //                 return ListView.builder(
// //                   reverse: true,
// //                   itemCount: messagesList.length,
// //                   itemBuilder: (context, index) {
// //                     final msg = messagesList[messagesList.length - 1 - index];
// //                     bool isMe = msg['senderId'] == currentUserId;
// //
// //                     return Align(
// //                       alignment:
// //                           isMe ? Alignment.centerRight : Alignment.centerLeft,
// //                       child: Container(
// //                         margin: const EdgeInsets.symmetric(
// //                             vertical: 4, horizontal: 8),
// //                         padding: const EdgeInsets.all(12),
// //                         decoration: BoxDecoration(
// //                           color:
// //                               isMe ? Colors.blueAccent : Colors.grey.shade300,
// //                           borderRadius: BorderRadius.circular(12),
// //                         ),
// //                         child: Text(
// //                           msg['text'],
// //                           style: TextStyle(
// //                               color: isMe ? Colors.white : Colors.black87),
// //                         ),
// //                       ),
// //                     );
// //                   },
// //                 );
// //               },
// //             ),
// //           ),
// //           Padding(
// //             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
// //             child: Row(
// //               children: [
// //                 Expanded(
// //                   child: TextField(
// //                     controller: _messageController,
// //                     decoration: const InputDecoration(
// //                       hintText: "Type a message",
// //                       border: OutlineInputBorder(),
// //                     ),
// //                     onSubmitted: (_) => sendMessage(),
// //                   ),
// //                 ),
// //                 const SizedBox(width: 8),
// //                 IconButton(
// //                   icon: const Icon(Icons.send),
// //                   onPressed: sendMessage,
// //                   color: Colors.blueAccent,
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// // import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:firebase_database/firebase_database.dart';
// //
// // class ChatScreen extends StatefulWidget {
// //   final String receiverId;
// //   final String receiverName;
// //
// //   const ChatScreen({
// //     Key? key,
// //     required this.receiverId,
// //     required this.receiverName,
// //   }) : super(key: key);
// //
// //   @override
// //   State<ChatScreen> createState() => _ChatScreenState();
// // }
// //
// // class _ChatScreenState extends State<ChatScreen> {
// //   final TextEditingController _messageController = TextEditingController();
// //   final FirebaseAuth _auth = FirebaseAuth.instance;
// //   final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
// //
// //   late String chatId;
// //   late String currentUserId;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     currentUserId = _auth.currentUser!.uid;
// //
// //     chatId = currentUserId.compareTo(widget.receiverId) < 0
// //         ? '${currentUserId}_${widget.receiverId}'
// //         : '${widget.receiverId}_${currentUserId}';
// //   }
// //
// //   void sendMessage() async {
// //     String message = _messageController.text.trim();
// //     if (message.isEmpty) return;
// //
// //     final timestamp = DateTime.now().millisecondsSinceEpoch;
// //     final newMsgRef = _dbRef.child('messages').child(chatId).push();
// //
// //     await newMsgRef.set({
// //       'senderId': currentUserId,
// //       'text': message,
// //       'timestamp': timestamp,
// //       'seen': false,
// //     });
// //
// //     _messageController.clear();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text(widget.receiverName)),
// //       body: Column(
// //         children: [
// //           Expanded(
// //             child: StreamBuilder(
// //               stream: _dbRef
// //                   .child('messages')
// //                   .child(chatId)
// //                   .orderByChild('timestamp')
// //                   .onValue,
// //               builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
// //                 if (!snapshot.hasData ||
// //                     snapshot.data!.snapshot.value == null) {
// //                   return const Center(child: Text('No messages yet'));
// //                 }
// //
// //                 Map<dynamic, dynamic> messagesMap =
// //                     snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
// //
// //                 List<dynamic> messagesList = messagesMap.entries
// //                     .map((e) => e.value as Map<dynamic, dynamic>)
// //                     .toList();
// //
// //                 messagesList
// //                     .sort((a, b) => a['timestamp'].compareTo(b['timestamp']));
// //
// //                 return ListView.builder(
// //                   reverse: true,
// //                   itemCount: messagesList.length,
// //                   itemBuilder: (context, index) {
// //                     final msg = messagesList[messagesList.length - 1 - index];
// //                     bool isMe = msg['senderId'] == currentUserId;
// //
// //                     return Align(
// //                       alignment:
// //                           isMe ? Alignment.centerRight : Alignment.centerLeft,
// //                       child: Container(
// //                         margin: const EdgeInsets.symmetric(
// //                             vertical: 4, horizontal: 8),
// //                         padding: const EdgeInsets.all(12),
// //                         decoration: BoxDecoration(
// //                           color:
// //                               isMe ? Colors.blueAccent : Colors.grey.shade300,
// //                           borderRadius: BorderRadius.circular(12),
// //                         ),
// //                         child: Text(
// //                           msg['text'],
// //                           style: TextStyle(
// //                               color: isMe ? Colors.white : Colors.black87),
// //                         ),
// //                       ),
// //                     );
// //                   },
// //                 );
// //               },
// //             ),
// //           ),
// //           Padding(
// //             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
// //             child: Row(
// //               children: [
// //                 Expanded(
// //                   child: TextField(
// //                     controller: _messageController,
// //                     decoration: const InputDecoration(
// //                       hintText: "Type a message",
// //                       border: OutlineInputBorder(),
// //                     ),
// //                     onSubmitted: (_) => sendMessage(),
// //                   ),
// //                 ),
// //                 const SizedBox(width: 8),
// //                 IconButton(
// //                   icon: const Icon(Icons.send),
// //                   onPressed: sendMessage,
// //                   color: Colors.blueAccent,
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// // import 'package:flutter/material.dart';
// // import 'package:firebase_database/firebase_database.dart';
// //
// // class ChatScreen extends StatefulWidget {
// //   final String receiverId;
// //   final String receiverName;
// //
// //   const ChatScreen({
// //     super.key,
// //     required this.receiverId,
// //     required this.receiverName,
// //   });
// //
// //   @override
// //   State<ChatScreen> createState() => _ChatScreenState();
// // }
// //
// // class _ChatScreenState extends State<ChatScreen> {
// //   final TextEditingController _messageController = TextEditingController();
// //   final String currentUserId =
// //       "UUJk0FyC4gNSEgPB5wotcT6uX6k2"; // replace with actual logged in user
// //
// //   DatabaseReference get chatRef {
// //     String chatId = currentUserId.compareTo(widget.receiverId) < 0
// //         ? "${currentUserId}_${widget.receiverId}"
// //         : "${widget.receiverId}_${currentUserId}";
// //
// //     return FirebaseDatabase.instance.ref().child("messages").child(chatId);
// //   }
// //
// //   void _sendMessage() {
// //     if (_messageController.text.trim().isEmpty) return;
// //
// //     final message = {
// //       "senderId": currentUserId,
// //       "receiverId": widget.receiverId,
// //       "message": _messageController.text.trim(),
// //       "timestamp": DateTime.now().millisecondsSinceEpoch,
// //     };
// //
// //     chatRef.push().set(message);
// //     _messageController.clear();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text("Chat with ${widget.receiverName}")),
// //       body: Column(
// //         children: [
// //           Expanded(
// //             child: StreamBuilder(
// //               stream: chatRef.orderByChild("timestamp").onValue,
// //               builder: (context, snapshot) {
// //                 if (!snapshot.hasData ||
// //                     snapshot.data!.snapshot.value == null) {
// //                   return const Center(child: Text("No messages yet."));
// //                 }
// //
// //                 final messages = Map<String, dynamic>.from(
// //                     snapshot.data!.snapshot.value as Map);
// //
// //                 final messageList = messages.values.toList()
// //                   ..sort((a, b) => a['timestamp'].compareTo(b['timestamp']));
// //
// //                 return ListView.builder(
// //                   itemCount: messageList.length,
// //                   itemBuilder: (context, index) {
// //                     final msg = Map<String, dynamic>.from(messageList[index]);
// //                     final isMe = msg["senderId"] == currentUserId;
// //
// //                     return Align(
// //                       alignment:
// //                           isMe ? Alignment.centerRight : Alignment.centerLeft,
// //                       child: Container(
// //                         margin: const EdgeInsets.all(8),
// //                         padding: const EdgeInsets.all(10),
// //                         decoration: BoxDecoration(
// //                           color: isMe ? Colors.blue[100] : Colors.grey[300],
// //                           borderRadius: BorderRadius.circular(10),
// //                         ),
// //                         child: Text(msg["message"]),
// //                       ),
// //                     );
// //                   },
// //                 );
// //               },
// //             ),
// //           ),
// //           Padding(
// //             padding: const EdgeInsets.all(10.0),
// //             child: Row(
// //               children: [
// //                 Expanded(
// //                   child: TextField(
// //                     controller: _messageController,
// //                     decoration:
// //                         const InputDecoration(hintText: "Type a message"),
// //                   ),
// //                 ),
// //                 IconButton(
// //                   icon: const Icon(Icons.send),
// //                   onPressed: _sendMessage,
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';
//
// class ChatScreen extends StatefulWidget {
//   final String receiverId;
//   final String receiverName;
//
//   const ChatScreen({
//     super.key,
//     required this.receiverId,
//     required this.receiverName,
//   });
//
//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _messageController = TextEditingController();
//   final String currentUserId =
//       "wW2be77XqoVIf2EcExCroSesaDi1"; // replace with actual logged in user
//
//   DatabaseReference get chatRef {
//     String chatId = currentUserId.compareTo(widget.receiverId) < 0
//         ? "${currentUserId}_${widget.receiverId}"
//         : "${widget.receiverId}_${currentUserId}";
//
//     return FirebaseDatabase.instance.ref().child("messages").child(chatId);
//   }
//
//   void _sendMessage() {
//     if (_messageController.text.trim().isEmpty) return;
//
//     final message = {
//       "senderId": currentUserId,
//       "receiverId": widget.receiverId,
//       "message": _messageController.text.trim(),
//       "timestamp": DateTime.now().millisecondsSinceEpoch,
//     };
//
//     chatRef.push().set(message);
//     _messageController.clear();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Chat with ${widget.receiverName}")),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder(
//               stream: chatRef.orderByChild("timestamp").onValue,
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData ||
//                     snapshot.data!.snapshot.value == null) {
//                   return const Center(child: Text("No messages yet."));
//                 }
//
//                 final messages = Map<String, dynamic>.from(
//                     snapshot.data!.snapshot.value as Map);
//
//                 final messageList = messages.values.toList()
//                   ..sort((a, b) => a['timestamp'].compareTo(b['timestamp']));
//
//                 return ListView.builder(
//                   itemCount: messageList.length,
//                   itemBuilder: (context, index) {
//                     final msg = Map<String, dynamic>.from(messageList[index]);
//                     final isMe = msg["senderId"] == currentUserId;
//
//                     return Align(
//                       alignment:
//                           isMe ? Alignment.centerRight : Alignment.centerLeft,
//                       child: Container(
//                         margin: const EdgeInsets.all(8),
//                         padding: const EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           color: isMe ? Colors.blue[100] : Colors.grey[300],
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Text(msg["message"]),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _messageController,
//                     decoration:
//                         const InputDecoration(hintText: "Type a message"),
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.send),
//                   onPressed: _sendMessage,
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
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatefulWidget {
  final String receiverId;
  final String receiverName;

  const ChatScreen({required this.receiverId, required this.receiverName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _msgController = TextEditingController();
  final dbRef = FirebaseDatabase.instance.ref();
  final currentUser = FirebaseAuth.instance.currentUser;

  late String chatId;

  @override
  void initState() {
    super.initState();
    chatId = _generateChatId(currentUser!.uid, widget.receiverId);
  }

  String _generateChatId(String a, String b) {
    return a.hashCode <= b.hashCode ? '${a}_$b' : '${b}_$a';
  }

  void _sendMessage() {
    final text = _msgController.text.trim();
    if (text.isEmpty) return;

    final msgRef = dbRef.child('messages/$chatId').push();
    msgRef.set({
      'senderId': currentUser!.uid,
      'receiverId': widget.receiverId,
      'text': text,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'seen': false,
    });

    _msgController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat with ${widget.receiverName}")),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: dbRef
                  .child("messages/$chatId")
                  .orderByChild("timestamp")
                  .onValue,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
                  Map data = snapshot.data!.snapshot.value as Map;
                  List items = data.entries.toList()
                    ..sort((a, b) =>
                        a.value["timestamp"].compareTo(b.value["timestamp"]));

                  return ListView(
                    children: items.map((e) {
                      bool isMe = e.value["senderId"] == currentUser!.uid;
                      return Align(
                        alignment:
                            isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          margin:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          decoration: BoxDecoration(
                            color: isMe ? Colors.green[100] : Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(e.value["text"]),
                        ),
                      );
                    }).toList(),
                  );
                } else {
                  return Center(child: Text("No messages yet"));
                }
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _msgController,
                  decoration: const InputDecoration(
                    hintText: "Type a message...",
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: _sendMessage,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
