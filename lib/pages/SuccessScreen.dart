import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../dashboard/user_dashboard.dart';
import 'BookingSummaryPage.dart';

class SuccessScreen extends StatelessWidget {
  final String bookingId;
  final String userId;
  final String providerId;
  final String providerName;
  final String date;
  final String time;
  final String status;

  const SuccessScreen({
    super.key,
    required this.bookingId,
    required this.userId,
    required this.providerId,
    required this.providerName,
    required this.date,
    required this.time,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          // ✅ scrolling overflow fix
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ✅ Lottie animation
                Lottie.asset(
                  'assets/Animation - 1750982121003.json',
                  width: 200,
                  height: 200,
                  repeat: false,
                ),

                const SizedBox(height: 20),
                const Text(
                  'Booking Confirmed!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),

                const SizedBox(height: 10),
                Text(
                  'Provider: $providerName\nDate: $date\nTime: $time',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),

                const SizedBox(height: 30),

                ElevatedButton.icon(
                  icon: const Icon(Icons.receipt_long),
                  label: const Text("View Summary"),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BookingSummaryPage(
                          bookingId: bookingId,
                          userId: userId,
                          providerId: providerId,
                          providerName: providerName,
                          date: date,
                          time: time,
                          status: status,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black12,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                ),

                const SizedBox(height: 12),

                TextButton.icon(
                  icon: const Icon(Icons.home),
                  label: const Text("UserDashboard"),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const UserDashboard()),
                      (route) => false,
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
