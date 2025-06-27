// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
//
// class ProviderBookingScreen extends StatefulWidget {
//   const ProviderBookingScreen({super.key});
//
//   @override
//   State<ProviderBookingScreen> createState() => _ProviderBookingScreenState();
// }
//
// class _ProviderBookingScreenState extends State<ProviderBookingScreen> {
//   final providerId = FirebaseAuth.instance.currentUser!.uid;
//   final _dbRef = FirebaseDatabase.instance.ref();
//
//   List<Map<String, dynamic>> bookings = [];
//
//   @override
//   void initState() {
//     super.initState();
//     fetchBookings();
//   }
//
//   void fetchBookings() async {
//     final snapshot = await _dbRef
//         .child('bookings')
//         .orderByChild('providerId')
//         .equalTo(providerId)
//         .get();
//     if (snapshot.exists) {
//       final data = snapshot.value as Map<dynamic, dynamic>;
//       final List<Map<String, dynamic>> temp = [];
//
//       data.forEach((key, value) {
//         temp.add(Map<String, dynamic>.from(value));
//       });
//
//       setState(() {
//         bookings = temp;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("My Bookings")),
//       body: bookings.isEmpty
//           ? const Center(child: Text("No bookings found"))
//           : ListView.builder(
//               itemCount: bookings.length,
//               itemBuilder: (context, index) {
//                 final booking = bookings[index];
//
//                 return Card(
//                   margin: const EdgeInsets.all(10),
//                   child: ListTile(
//                     title: Text("Service: ${booking['service'] ?? ''}"),
//                     subtitle: Text(
//                         "User: ${booking['userEmail'] ?? ''}\nDate: ${booking['date'] ?? ''}"),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:intl/intl.dart';
//
// class BookingScreen extends StatefulWidget {
//   final String providerId;
//   final String providerName;
//
//   const BookingScreen({
//     super.key,
//     required this.providerId,
//     required this.providerName,
//   });
//
//   @override
//   State<BookingScreen> createState() => _BookingScreenState();
// }
//
// class _BookingScreenState extends State<BookingScreen> {
//   DateTime? selectedDate;
//   TimeOfDay? selectedTime;
//
//   void _selectDate() async {
//     final now = DateTime.now();
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: now,
//       firstDate: now,
//       lastDate: DateTime(now.year + 1),
//     );
//     if (picked != null) {
//       setState(() {
//         selectedDate = picked;
//       });
//     }
//   }
//
//   void _selectTime() async {
//     final picked = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//     if (picked != null) {
//       setState(() {
//         selectedTime = picked;
//       });
//     }
//   }
//
//   void _confirmBooking() async {
//     if (selectedDate == null || selectedTime == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please select date and time")),
//       );
//       return;
//     }
//
//     final currentUser = FirebaseDatabase.instance
//         .ref()
//         .child("current_user_id"); // use actual auth uid
//     final bookingsRef =
//         FirebaseDatabase.instance.ref().child("bookings").push();
//
//     await bookingsRef.set({
//       "providerId": widget.providerId,
//       "providerName": widget.providerName,
//       "date": DateFormat('yyyy-MM-dd').format(selectedDate!),
//       "time": selectedTime!.format(context),
//       "status": "pending",
//       "userId":
//           "UUJk0FyC4gNSEgPB5wotcT6uX6k2", // replace with actual logged in user id
//     });
//
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Booking confirmed!")),
//     );
//     Navigator.pop(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Book ${widget.providerName}")),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             ListTile(
//               title: Text(selectedDate == null
//                   ? "Select Date"
//                   : DateFormat('yyyy-MM-dd').format(selectedDate!)),
//               trailing: const Icon(Icons.calendar_today),
//               onTap: _selectDate,
//             ),
//             ListTile(
//               title: Text(selectedTime == null
//                   ? "Select Time"
//                   : selectedTime!.format(context)),
//               trailing: const Icon(Icons.access_time),
//               onTap: _selectTime,
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _confirmBooking,
//               child: const Text("Confirm Booking"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
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
