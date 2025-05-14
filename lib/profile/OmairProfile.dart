import 'package:flutter/material.dart';

class OmairProfile extends StatelessWidget {
  const OmairProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Omair's Profile")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/omair.jpg'),
              radius: 60,
            ),
            SizedBox(height: 20),
            Text("Name: Omair", style: TextStyle(fontSize: 18)),
            Text("Profession: Driver", style: TextStyle(fontSize: 18)),
            Text("Rating: 4.6", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("Email: omair.driver@example.com",
                style: TextStyle(fontSize: 16)),
            Text("Location: Chattogram, Bangladesh",
                style: TextStyle(fontSize: 16)),
            Text("Phone: +8801678123456", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
