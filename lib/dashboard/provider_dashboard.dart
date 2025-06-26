// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
//
// import '../pages/ChatScreen.dart';
//
// class ProviderDashboard extends StatefulWidget {
//   const ProviderDashboard({Key? key}) : super(key: key);
//
//   @override
//   State<ProviderDashboard> createState() => _ProviderDashboardState();
// }
//
// class _ProviderDashboardState extends State<ProviderDashboard> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final DatabaseReference _chatsRef =
//       FirebaseDatabase.instance.ref().child('messages');
//   final DatabaseReference _usersRef =
//       FirebaseDatabase.instance.ref().child('users');
//   final DatabaseReference _providersRef =
//       FirebaseDatabase.instance.ref().child('providers');
//
//   late String providerId;
//   Map<String, dynamic> recentChats = {}; // chatId -> lastMessage map
//   Map<String, String> userNames = {}; // userId -> userName
//   Map<String, String> providerNames = {}; // providerId -> providerName
//
//   bool loading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     providerId = _auth.currentUser!.uid;
//     _fetchNamesAndChats();
//   }
//
//   Future<void> _fetchNamesAndChats() async {
//     setState(() => loading = true);
//
//     // ১. ইউজার ও প্রোভাইডারদের নাম একবারে নিয়ে নাও
//     final usersSnap = await _usersRef.get();
//     final providersSnap = await _providersRef.get();
//
//     if (usersSnap.exists) {
//       final usersData = Map<String, dynamic>.from(usersSnap.value as dynamic);
//       usersData.forEach((key, value) {
//         userNames[key] = value['name'] ?? 'User';
//       });
//     }
//
//     if (providersSnap.exists) {
//       final providersData =
//           Map<String, dynamic>.from(providersSnap.value as dynamic);
//       providersData.forEach((key, value) {
//         providerNames[key] = value['name'] ?? 'Provider';
//       });
//     }
//
//     // ২. চ্যাট লোড করো
//     _chatsRef.onValue.listen((event) {
//       final data = event.snapshot.value as Map<dynamic, dynamic>?;
//
//       if (data != null) {
//         Map<String, dynamic> filteredChats = {};
//
//         data.forEach((chatId, messagesMap) {
//           if (chatId.toString().contains(providerId)) {
//             Map<dynamic, dynamic> msgs =
//                 Map<dynamic, dynamic>.from(messagesMap);
//
//             var lastMessage = msgs.values.reduce((curr, next) =>
//                 curr['timestamp'] > next['timestamp'] ? curr : next);
//
//             filteredChats[chatId] = lastMessage;
//           }
//         });
//
//         setState(() {
//           recentChats = filteredChats;
//           loading = false;
//         });
//       } else {
//         setState(() {
//           recentChats = {};
//           loading = false;
//         });
//       }
//     });
//   }
//
//   String _getChatPartnerName(String chatId) {
//     List<String> ids = chatId.split('_');
//     String otherId = ids[0] == providerId ? ids[1] : ids[0];
//
//     // ইউজার হলে userNames থেকে নাও, না হলে providerNames থেকে নাও
//     if (userNames.containsKey(otherId)) {
//       return userNames[otherId]!;
//     } else if (providerNames.containsKey(otherId)) {
//       return providerNames[otherId]!;
//     } else {
//       return 'Unknown';
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Provider Dashboard - Messages'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: _fetchNamesAndChats,
//             tooltip: 'Refresh',
//           )
//         ],
//       ),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : recentChats.isEmpty
//               ? const Center(child: Text('No recent chats'))
//               : ListView.builder(
//                   itemCount: recentChats.length,
//                   itemBuilder: (context, index) {
//                     String chatId = recentChats.keys.elementAt(index);
//                     var lastMsg = recentChats[chatId];
//                     String partnerName = _getChatPartnerName(chatId);
//
//                     return ListTile(
//                       title: Text('Chat with $partnerName'),
//                       subtitle: Text(lastMsg['text']),
//                       trailing: Text(
//                         DateTime.fromMillisecondsSinceEpoch(
//                                 lastMsg['timestamp'])
//                             .toLocal()
//                             .toString()
//                             .substring(11, 16),
//                         style: const TextStyle(fontSize: 12),
//                       ),
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (_) => ChatScreen(
//                               receiverId: partnerName == 'Unknown'
//                                   ? '' // Prevent crash if unknown
//                                   : chatId
//                                       .replaceAll(providerId, '')
//                                       .replaceAll('_', ''),
//                               receiverName: partnerName,
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../pages/ChatScreen.dart';

class ProviderDashboard extends StatefulWidget {
  const ProviderDashboard({Key? key}) : super(key: key);

  @override
  State<ProviderDashboard> createState() => _ProviderDashboardState();
}

class _ProviderDashboardState extends State<ProviderDashboard> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _dbRef =
      FirebaseDatabase.instance.ref().child('messages');

  late String providerId;
  Map<String, dynamic> recentChats = {};

  @override
  void initState() {
    super.initState();
    providerId = _auth.currentUser!.uid;
    _loadRecentChats();
  }

  void _loadRecentChats() {
    _dbRef.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;

      if (data != null) {
        Map<String, dynamic> filteredChats = {};

        data.forEach((chatId, messagesMap) {
          if (chatId.toString().contains(providerId)) {
            Map<dynamic, dynamic> msgs =
                Map<dynamic, dynamic>.from(messagesMap);

            var lastMessage = msgs.values.reduce((curr, next) =>
                curr['timestamp'] > next['timestamp'] ? curr : next);

            filteredChats[chatId] = lastMessage;
          }
        });

        setState(() {
          recentChats = filteredChats;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Provider Dashboard - Messages")),
      body: recentChats.isEmpty
          ? const Center(child: Text("No chats yet"))
          : ListView.builder(
              itemCount: recentChats.length,
              itemBuilder: (context, index) {
                String chatId = recentChats.keys.elementAt(index);
                var lastMsg = recentChats[chatId];

                List<String> ids = chatId.split('_');
                String otherUserId = ids[0] == providerId ? ids[1] : ids[0];

                return ListTile(
                  title: Text("Chat with $otherUserId"),
                  subtitle: Text(lastMsg['text']),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatScreen(
                          receiverId: otherUserId,
                          receiverName: 'User',
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
