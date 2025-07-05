import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ProviderBookingScreen extends StatefulWidget {
  const ProviderBookingScreen({super.key});

  @override
  State<ProviderBookingScreen> createState() => _ProviderBookingScreenState();
}

class _ProviderBookingScreenState extends State<ProviderBookingScreen> {
  final providerId = FirebaseAuth.instance.currentUser!.uid;
  final _dbRef = FirebaseDatabase.instance.ref();

  List<Map<String, dynamic>> bookings = [];

  @override
  void initState() {
    super.initState();
    fetchBookings();
  }

  void fetchBookings() async {
    final snapshot = await _dbRef
        .child('bookings')
        .orderByChild('providerId')
        .equalTo(providerId)
        .get();
    if (snapshot.exists) {
      final data = snapshot.value as Map<dynamic, dynamic>;
      final List<Map<String, dynamic>> temp = [];

      data.forEach((key, value) {
        temp.add(Map<String, dynamic>.from(value));
      });

      setState(() {
        bookings = temp;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Bookings")),
      body: bookings.isEmpty
          ? const Center(child: Text("No bookings found"))
          : ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final booking = bookings[index];

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text("Service: ${booking['service'] ?? ''}"),
                    subtitle: Text(
                        "User: ${booking['userEmail'] ?? ''}\nDate: ${booking['date'] ?? ''}"),
                  ),
                );
              },
            ),
    );
  }
}
