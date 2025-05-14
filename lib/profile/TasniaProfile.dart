import 'package:flutter/material.dart';

class TasniaProfile extends StatelessWidget {
  const TasniaProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tasnia's Profile")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/tasnia.png'),
              radius: 60,
            ),
            SizedBox(height: 20),
            Text("Name: Tasnia", style: TextStyle(fontSize: 18)),
            Text("Profession: Tailor", style: TextStyle(fontSize: 18)),
            Text("Rating: 4.4", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("Email: tasnia.tailor@example.com",
                style: TextStyle(fontSize: 16)),
            Text("Location: Dhaka, Bangladesh", style: TextStyle(fontSize: 16)),
            Text("Phone: +8801523456789", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
