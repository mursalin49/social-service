import 'package:flutter/material.dart';

class HridoyProfile extends StatelessWidget {
  const HridoyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hridoy's Profile")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/hridoy.jpg'),
              radius: 60,
            ),
            SizedBox(height: 20),
            Text("Name: Hridoy", style: TextStyle(fontSize: 18)),
            Text("Profession: Electrician", style: TextStyle(fontSize: 18)),
            Text("Rating: 4.8", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("Email: hridoy.electrician@example.com",
                style: TextStyle(fontSize: 16)),
            Text("Location: Dhaka, Bangladesh", style: TextStyle(fontSize: 16)),
            Text("Phone: +8801234567890", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
