import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'SuccessScreen.dart';

class BookingScreen extends StatefulWidget {
  final String providerId;
  final String providerName;

  const BookingScreen({required this.providerId, required this.providerName});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _dbRef = FirebaseDatabase.instance.ref();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  void _confirmBooking() async {
    if (selectedDate == null || selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Select date & time")),
      );
      return;
    }

    final user = FirebaseAuth.instance.currentUser!;
    final bookingRef = _dbRef.child("bookings").push();
    final bookingId = bookingRef.key;

    final bookingData = {
      "bookingId": bookingId,
      "userId": user.uid,
      "userEmail": user.email,
      "providerId": widget.providerId,
      "providerName": widget.providerName,
      "date":
          "${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}",
      "time": selectedTime!.format(context),
      "status": "pending"
    };

    await bookingRef.set(bookingData);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => SuccessScreen(
          bookingId: bookingId!,
          userId: user.uid,
          providerId: widget.providerId,
          providerName: widget.providerName,
          date: bookingData['date']!,
          time: bookingData['time']!,
          status: bookingData['status']!,
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 0),
    );
    if (picked != null) {
      setState(() => selectedTime = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Book ${widget.providerName}"),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        elevation: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Select Date",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              icon: const Icon(Icons.calendar_today),
              onPressed: _pickDate,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.deepPurple,
                elevation: 2,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              label: Text(
                selectedDate == null
                    ? "Choose Date"
                    : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Select Time",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              icon: const Icon(Icons.access_time),
              onPressed: _pickTime,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.deepPurple,
                elevation: 2,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              label: Text(
                selectedTime == null
                    ? "Choose Time"
                    : selectedTime!.format(context),
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _confirmBooking,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Confirm Booking",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
