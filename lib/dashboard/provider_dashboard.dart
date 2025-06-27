// // import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:firebase_database/firebase_database.dart';
// //
// // import '../pages/ChatScreen.dart';
// //
// // class ProviderDashboard extends StatefulWidget {
// //   const ProviderDashboard({Key? key}) : super(key: key);
// //
// //   @override
// //   State<ProviderDashboard> createState() => _ProviderDashboardState();
// // }
// //
// // class _ProviderDashboardState extends State<ProviderDashboard> {
// //   final FirebaseAuth _auth = FirebaseAuth.instance;
// //   final DatabaseReference _chatsRef =
// //       FirebaseDatabase.instance.ref().child('messages');
// //   final DatabaseReference _usersRef =
// //       FirebaseDatabase.instance.ref().child('users');
// //   final DatabaseReference _providersRef =
// //       FirebaseDatabase.instance.ref().child('providers');
// //
// //   late String providerId;
// //   Map<String, dynamic> recentChats = {}; // chatId -> lastMessage map
// //   Map<String, String> userNames = {}; // userId -> userName
// //   Map<String, String> providerNames = {}; // providerId -> providerName
// //
// //   bool loading = true;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     providerId = _auth.currentUser!.uid;
// //     _fetchNamesAndChats();
// //   }
// //
// //   Future<void> _fetchNamesAndChats() async {
// //     setState(() => loading = true);
// //
// //     // ১. ইউজার ও প্রোভাইডারদের নাম একবারে নিয়ে নাও
// //     final usersSnap = await _usersRef.get();
// //     final providersSnap = await _providersRef.get();
// //
// //     if (usersSnap.exists) {
// //       final usersData = Map<String, dynamic>.from(usersSnap.value as dynamic);
// //       usersData.forEach((key, value) {
// //         userNames[key] = value['name'] ?? 'User';
// //       });
// //     }
// //
// //     if (providersSnap.exists) {
// //       final providersData =
// //           Map<String, dynamic>.from(providersSnap.value as dynamic);
// //       providersData.forEach((key, value) {
// //         providerNames[key] = value['name'] ?? 'Provider';
// //       });
// //     }
// //
// //     // ২. চ্যাট লোড করো
// //     _chatsRef.onValue.listen((event) {
// //       final data = event.snapshot.value as Map<dynamic, dynamic>?;
// //
// //       if (data != null) {
// //         Map<String, dynamic> filteredChats = {};
// //
// //         data.forEach((chatId, messagesMap) {
// //           if (chatId.toString().contains(providerId)) {
// //             Map<dynamic, dynamic> msgs =
// //                 Map<dynamic, dynamic>.from(messagesMap);
// //
// //             var lastMessage = msgs.values.reduce((curr, next) =>
// //                 curr['timestamp'] > next['timestamp'] ? curr : next);
// //
// //             filteredChats[chatId] = lastMessage;
// //           }
// //         });
// //
// //         setState(() {
// //           recentChats = filteredChats;
// //           loading = false;
// //         });
// //       } else {
// //         setState(() {
// //           recentChats = {};
// //           loading = false;
// //         });
// //       }
// //     });
// //   }
// //
// //   String _getChatPartnerName(String chatId) {
// //     List<String> ids = chatId.split('_');
// //     String otherId = ids[0] == providerId ? ids[1] : ids[0];
// //
// //     // ইউজার হলে userNames থেকে নাও, না হলে providerNames থেকে নাও
// //     if (userNames.containsKey(otherId)) {
// //       return userNames[otherId]!;
// //     } else if (providerNames.containsKey(otherId)) {
// //       return providerNames[otherId]!;
// //     } else {
// //       return 'Unknown';
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Provider Dashboard - Messages'),
// //         actions: [
// //           IconButton(
// //             icon: const Icon(Icons.refresh),
// //             onPressed: _fetchNamesAndChats,
// //             tooltip: 'Refresh',
// //           )
// //         ],
// //       ),
// //       body: loading
// //           ? const Center(child: CircularProgressIndicator())
// //           : recentChats.isEmpty
// //               ? const Center(child: Text('No recent chats'))
// //               : ListView.builder(
// //                   itemCount: recentChats.length,
// //                   itemBuilder: (context, index) {
// //                     String chatId = recentChats.keys.elementAt(index);
// //                     var lastMsg = recentChats[chatId];
// //                     String partnerName = _getChatPartnerName(chatId);
// //
// //                     return ListTile(
// //                       title: Text('Chat with $partnerName'),
// //                       subtitle: Text(lastMsg['text']),
// //                       trailing: Text(
// //                         DateTime.fromMillisecondsSinceEpoch(
// //                                 lastMsg['timestamp'])
// //                             .toLocal()
// //                             .toString()
// //                             .substring(11, 16),
// //                         style: const TextStyle(fontSize: 12),
// //                       ),
// //                       onTap: () {
// //                         Navigator.push(
// //                           context,
// //                           MaterialPageRoute(
// //                             builder: (_) => ChatScreen(
// //                               receiverId: partnerName == 'Unknown'
// //                                   ? '' // Prevent crash if unknown
// //                                   : chatId
// //                                       .replaceAll(providerId, '')
// //                                       .replaceAll('_', ''),
// //                               receiverName: partnerName,
// //                             ),
// //                           ),
// //                         );
// //                       },
// //                     );
// //                   },
// //                 ),
// //     );
// //   }
// // }
// // import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:firebase_database/firebase_database.dart';
// // import '../pages/ChatScreen.dart';
// //
// // class ProviderDashboard extends StatefulWidget {
// //   const ProviderDashboard({Key? key}) : super(key: key);
// //
// //   @override
// //   State<ProviderDashboard> createState() => _ProviderDashboardState();
// // }
// //
// // class _ProviderDashboardState extends State<ProviderDashboard> {
// //   final FirebaseAuth _auth = FirebaseAuth.instance;
// //   final DatabaseReference _dbRef =
// //       FirebaseDatabase.instance.ref().child('messages');
// //
// //   late String providerId;
// //   Map<String, dynamic> recentChats = {};
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     providerId = _auth.currentUser!.uid;
// //     _loadRecentChats();
// //   }
// //
// //   void _loadRecentChats() {
// //     _dbRef.onValue.listen((event) {
// //       final data = event.snapshot.value as Map<dynamic, dynamic>?;
// //
// //       if (data != null) {
// //         Map<String, dynamic> filteredChats = {};
// //
// //         data.forEach((chatId, messagesMap) {
// //           if (chatId.toString().contains(providerId)) {
// //             Map<dynamic, dynamic> msgs =
// //                 Map<dynamic, dynamic>.from(messagesMap);
// //
// //             var lastMessage = msgs.values.reduce((curr, next) =>
// //                 curr['timestamp'] > next['timestamp'] ? curr : next);
// //
// //             filteredChats[chatId] = lastMessage;
// //           }
// //         });
// //
// //         setState(() {
// //           recentChats = filteredChats;
// //         });
// //       }
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text("Provider Dashboard - Messages")),
// //       body: recentChats.isEmpty
// //           ? const Center(child: Text("No chats yet"))
// //           : ListView.builder(
// //               itemCount: recentChats.length,
// //               itemBuilder: (context, index) {
// //                 String chatId = recentChats.keys.elementAt(index);
// //                 var lastMsg = recentChats[chatId];
// //
// //                 List<String> ids = chatId.split('_');
// //                 String otherUserId = ids[0] == providerId ? ids[1] : ids[0];
// //
// //                 return ListTile(
// //                   title: Text("Chat with $otherUserId"),
// //                   subtitle: Text(lastMsg['text']),
// //                   onTap: () {
// //                     Navigator.push(
// //                       context,
// //                       MaterialPageRoute(
// //                         builder: (_) => ChatScreen(
// //                           receiverId: otherUserId,
// //                           receiverName: 'User',
// //                         ),
// //                       ),
// //                     );
// //                   },
// //                 );
// //               },
// //             ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../auth/auth_service (1).dart';
// import '../auth/provider_login.dart';
// import '../pages/BookingScreen.dart';
// import '../pages/ProfileEditScreen.dart';
// import '../pages/provider_booking_screen.dart';
// import '../pages/provider_messages_screen.dart';
//
// class ProviderDashboard extends StatelessWidget {
//   const ProviderDashboard({super.key});
//
//   void _logout(BuildContext context) async {
//     await AuthService().signout();
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (_) => const ProviderLoginScreen()),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Provider Dashboard"),
//         backgroundColor: Colors.deepPurpleAccent,
//         actions: [
//           IconButton(
//             onPressed: () => _logout(context),
//             icon: const Icon(Icons.logout),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Text("Welcome, ${user?.email}",
//                 style: const TextStyle(fontSize: 18)),
//             const SizedBox(height: 30),
//             ElevatedButton.icon(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => const ProfileEditScreen()),
//                 );
//               },
//               icon: const Icon(Icons.edit),
//               label: const Text("Update Profile"),
//               style: ElevatedButton.styleFrom(backgroundColor: Colors.black12),
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton.icon(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (_) => const ProviderMessagesScreen()),
//                 );
//               },
//               icon: const Icon(Icons.message),
//               label: const Text("View Messages"),
//               style: ElevatedButton.styleFrom(backgroundColor: Colors.black12),
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton.icon(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => ProviderBookingScreen()),
//                 );
//               },
//               icon: const Icon(Icons.calendar_today),
//               label: const Text("View Bookings"),
//               style: ElevatedButton.styleFrom(backgroundColor: Colors.black12),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth/auth_service (1).dart';
import '../auth/provider_login.dart';
import '../pages/BookingScreen.dart';
import '../pages/ProfileEditScreen.dart';
import '../pages/provider_booking_screen.dart';
import '../pages/provider_messages_screen.dart';

class ProviderDashboard extends StatelessWidget {
  const ProviderDashboard({super.key});

  void _logout(BuildContext context) async {
    await AuthService().signout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const ProviderLoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Provider Dashboard"),
        backgroundColor: Colors.deepPurpleAccent,
        actions: [
          IconButton(
            onPressed: () => _logout(context),
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Text(
                "Welcome,\n${user?.email ?? "Provider"}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildDashboardTile(
                    context,
                    icon: Icons.edit,
                    label: "Update Profile",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const ProfileEditScreen()),
                      );
                    },
                  ),
                  _buildDashboardTile(
                    context,
                    icon: Icons.message,
                    label: "View Messages",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const ProviderMessagesScreen()),
                      );
                    },
                  ),
                  _buildDashboardTile(
                    context,
                    icon: Icons.calendar_today,
                    label: "View Bookings",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const ProviderBookingScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardTile(BuildContext context,
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.deepPurple[50],
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 40, color: Colors.deepPurple),
              const SizedBox(height: 10),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
