import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'ChatScreen.dart';
import 'date_time.dart';
import 'cleaner_model.dart'; // তোমার ক্লিনার মডেল

class CleaningPage extends StatefulWidget {
  const CleaningPage({Key? key}) : super(key: key);

  @override
  _CleaningPageState createState() => _CleaningPageState();
}

class _CleaningPageState extends State<CleaningPage> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance
      .ref()
      .child('providers'); // providers পাথ ঠিক আছে কিনা চেক করো

  List<Cleaner> _cleaners = [];

  @override
  void initState() {
    super.initState();
    _loadCleaners();
  }

  void _loadCleaners() async {
    final snapshot = await _dbRef.get();
    if (snapshot.exists) {
      final data = Map<String, dynamic>.from(snapshot.value as dynamic);
      print('Cleaners Data: $data'); // ডাটা কেমন আসছে কনসোলে দেখাবে

      setState(() {
        _cleaners = data.values
            .map((e) => Cleaner.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Available Cleaners")),
      body: _cleaners.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _cleaners.length,
              itemBuilder: (context, index) {
                final cleaner = _cleaners[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(cleaner.image),
                              radius: 30,
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cleaner.name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text("📞 ${cleaner.phone}"),
                                  Text("📍 ${cleaner.location}"),
                                  Text("🕒 ${cleaner.availability}"),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const DateAndTime(),
                                    ),
                                  );
                                },
                                child: const Text("Book Now"),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ChatScreen(
                                        receiverId: cleaner.uid,
                                        receiverName: cleaner.name,
                                      ),
                                    ),
                                  );
                                },
                                child: const Text("Message"),
                              ),
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
