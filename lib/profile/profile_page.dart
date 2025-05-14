import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nirob Hasan Profile'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/nirob.jpg'),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Nirob Hasan',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Cleaner',
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            const SizedBox(height: 20),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.star, color: Colors.orange),
              title: const Text('Rating'),
              trailing: const Text('4.9'),
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Email'),
              trailing: const Text('nirob@gmail.com'),
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('Phone'),
              trailing: const Text('+880 1752331906'),
            ),
            ListTile(
              leading: const Icon(Icons.location_city),
              title: const Text('Mirpur-02 , Dhaka'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text('Back to Dashboard'),
            )
          ],
        ),
      ),
    );
  }
}
