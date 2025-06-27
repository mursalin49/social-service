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
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "📋 All Bookings",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            if (allBookings.isEmpty)
              const Center(child: Text("No bookings found"))
            else
              ...allBookings.map((booking) => Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      leading: const Icon(Icons.book_online,
                          color: Colors.deepPurple),
                      title: Text("User: ${booking["userEmail"]}"),
                      subtitle: Text(
                        "Cleaner: ${booking["providerName"]}\nDate: ${booking["date"]} at ${booking["time"]}",
                      ),
                      trailing: Chip(
                        label: Text(
                          booking["status"].toString().toUpperCase(),
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: booking["status"] == "confirmed"
                            ? Colors.green
                            : Colors.orange,
                      ),
                    ),
                  )),
            const SizedBox(height: 24),
            const Text(
              "💬 All Chats",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            if (allChats.isEmpty)
              const Center(child: Text("No chat records found"))
            else
              ...allChats.map((chatId) => Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: const Icon(Icons.chat_bubble_outline,
                          color: Colors.deepPurple),
                      title: Text(chatId),
                    ),
                  )),
          ],
        ),
      ),
    );
  }
}
