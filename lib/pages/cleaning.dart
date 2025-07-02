// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'BookingScreen.dart';
// import 'ChatScreen.dart';
//
// class CleaningPage extends StatefulWidget {
//   const CleaningPage({super.key});
//
//   @override
//   State<CleaningPage> createState() => _CleaningPageState();
// }
//
// class _CleaningPageState extends State<CleaningPage> {
//   final dbRef = FirebaseDatabase.instance.ref().child("providers");
//   List<Map<String, dynamic>> providers = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchProviders();
//   }
//
//   void _fetchProviders() async {
//     final snapshot = await dbRef.get();
//     if (snapshot.exists) {
//       final data = snapshot.value as Map<dynamic, dynamic>;
//       List<Map<String, dynamic>> loaded = [];
//
//       data.forEach((key, value) {
//         loaded.add(Map<String, dynamic>.from(value));
//       });
//
//       setState(() {
//         providers = loaded;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       appBar: AppBar(
//         title: const Text("Available Providers"),
//         backgroundColor: Colors.deepPurple,
//         centerTitle: true,
//         elevation: 5,
//       ),
//       body: providers.isEmpty
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: providers.length,
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//               itemBuilder: (context, index) {
//                 final provider = providers[index];
//                 return Card(
//                   margin: const EdgeInsets.symmetric(vertical: 8),
//                   elevation: 6,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(15),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const CircleAvatar(
//                               radius: 35,
//                               backgroundImage:
//                                   AssetImage("assets/images/avatar.jpeg"),
//                             ),
//                             const SizedBox(width: 16),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     provider["name"] ?? "Unknown",
//                                     style: const TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 6),
//                                   Text("📞 ${provider["profession"] ?? "N/A"}"),
//                                   Text("📍 ${provider["location"] ?? "N/A"}"),
//                                   Text(
//                                       "🕐 ${provider["availability"] ?? "N/A"}"),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 15),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             ElevatedButton.icon(
//                               icon: const Icon(Icons.message, size: 22),
//                               label: const Text("Message Now"),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.blue,
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 12, vertical: 8),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                               ),
//                               onPressed: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (_) => ChatScreen(
//                                       receiverId: provider["uid"],
//                                       receiverName: provider["name"],
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                             ElevatedButton.icon(
//                               icon: const Icon(Icons.book_online, size: 22),
//                               label: const Text("Book Now"),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.green,
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 12, vertical: 8),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                               ),
//                               onPressed: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (_) => BookingScreen(
//                                       providerId: provider["uid"],
//                                       providerName: provider["name"],
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'BookingScreen.dart';
import 'ChatScreen.dart';

class CleaningPage extends StatefulWidget {
  const CleaningPage({super.key});

  @override
  State<CleaningPage> createState() => _CleaningPageState();
}

class _CleaningPageState extends State<CleaningPage> {
  final dbRef = FirebaseDatabase.instance.ref().child("providers");
  List<Map<String, dynamic>> providers = [];

  @override
  void initState() {
    super.initState();
    _fetchProviders();
  }

  void _fetchProviders() async {
    final snapshot = await dbRef.get();
    if (snapshot.exists) {
      final data = snapshot.value as Map<dynamic, dynamic>;
      List<Map<String, dynamic>> loaded = [];

      data.forEach((key, value) {
        final providerData = Map<String, dynamic>.from(value);
        if (providerData["profession"] == "Cleaner") {
          loaded.add(providerData);
        }
      });

      setState(() {
        providers = loaded;
      });
    }
  }

  IconData _getProfessionIcon(String? profession) {
    switch (profession) {
      case "Cleaner":
        return Icons.cleaning_services;
      case "Electrician":
        return Icons.electrical_services;
      case "Tailor":
        return Icons.cut;
      case "Driver":
        return Icons.directions_car;
      case "Caretaker":
        return Icons.health_and_safety;
      case "Cooker":
        return Icons.restaurant_menu;
      default:
        return Icons.person;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("Available Cleaners"),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        elevation: 5,
      ),
      body: providers.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: providers.length,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemBuilder: (context, index) {
                final provider = providers[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundImage: (provider["image"] != null &&
                                      provider["image"].toString().isNotEmpty)
                                  ? NetworkImage(provider["image"])
                                      as ImageProvider
                                  : const AssetImage(
                                      "assets/images/avatar.jpeg"),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        _getProfessionIcon(
                                            provider["profession"]),
                                        color: Colors.deepPurple,
                                      ),
                                      const SizedBox(width: 8),
                                      Flexible(
                                        child: Text(
                                          provider["name"] ?? "Unknown",
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text("📍 ${provider["location"] ?? "N/A"}"),
                                  Text(
                                      "🕐 ${provider["availability"] ?? "N/A"}"),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton.icon(
                              icon: const Icon(Icons.message, size: 22),
                              label: const Text("Message Now"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ChatScreen(
                                      receiverId: provider["uid"],
                                      receiverName: provider["name"],
                                    ),
                                  ),
                                );
                              },
                            ),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.book_online, size: 22),
                              label: const Text("Book Now"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => BookingScreen(
                                      providerId: provider["uid"],
                                      providerName: provider["name"],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
