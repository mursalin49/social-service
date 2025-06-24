import 'package:flutter/material.dart';
import '../pages/message.dart';

class ProviderDashboard extends StatefulWidget {
  const ProviderDashboard({super.key});

  @override
  _ProviderDashboardState createState() => _ProviderDashboardState();
}

class _ProviderDashboardState extends State<ProviderDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider Dashboard'),
        backgroundColor: const Color.fromRGBO(49, 39, 79, 1),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // TODO: এখানে লগআউট ফাংশনালিটি যোগ করবে
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Welcome, Service Provider!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(49, 39, 79, 1),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  _buildDashboardCard(
                    icon: Icons.list_alt,
                    title: 'My Services',
                    onTap: () {
                      // TODO: মাই সার্ভিসেস পেজে নেভিগেট করো
                    },
                  ),
                  _buildDashboardCard(
                    icon: Icons.message,
                    title: 'Messages',
                    onTap: () {
                      // ✅ Messages অপশনে ক্লিক করলে message.dart এ যাবে
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MessagePage(), // ✅
                        ),
                      );
                    },
                  ),
                  _buildDashboardCard(
                    icon: Icons.schedule,
                    title: 'Schedule',
                    onTap: () {
                      // TODO: শিডিউল পেজে নেভিগেট করো
                    },
                  ),
                  _buildDashboardCard(
                    icon: Icons.settings,
                    title: 'Settings',
                    onTap: () {
                      // TODO: সেটিংস পেজে নেভিগেট করো
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(196, 135, 198, 0.3),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: const Color.fromRGBO(49, 39, 79, 1)),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(49, 39, 79, 1),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
