import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final dbBookings = FirebaseDatabase.instance.ref().child("bookings");
  final dbMessages = FirebaseDatabase.instance.ref().child("messages");

  List<Map<String, dynamic>> allBookings = [];
  List<String> allChats = [];

  @override
  void initState() {
    super.initState();
    _fetchAll();
  }

  void _fetchAll() async {
    final bookingsSnap = await dbBookings.get();
    final messagesSnap = await dbMessages.get();

    if (bookingsSnap.exists) {
      final bookingsData = bookingsSnap.value as Map<dynamic, dynamic>;
      setState(() {
        allBookings = bookingsData.values
            .map((e) => Map<String, dynamic>.from(e))
            .toList();
      });
    }

    if (messagesSnap.exists) {
      final msgData = messagesSnap.value as Map<dynamic, dynamic>;
      setState(() {
        allChats = msgData.keys.map((e) => e.toString()).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin Panel")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text("All Bookings",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            ...allBookings.map((booking) => ListTile(
                  title: Text("User: ${booking["userEmail"]}"),
                  subtitle: Text(
                      "Cleaner: ${booking["providerName"]} | ${booking["date"]} ${booking["time"]}"),
                  trailing: Text(booking["status"]),
                )),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text("All Chats",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            ...allChats.map((chatId) => ListTile(title: Text(chatId))),
          ],
        ),
      ),
    );
  }
}
