import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart'; // যদি animate_do ব্যবহার করো
import '../auth/admin_login.dart';
import '../auth/provider_login.dart';
import '../auth/user_login_screen.dart';
// import '../auth/provider_login.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width; // screen width নেয়া

    return Scaffold(
      body: Stack(
        children: [
          // UserLoginScreen এর মতো Background Image with animation
          Container(
            height: 400,
            child: Stack(
              children: [
                Positioned(
                  top: -40,
                  height: 400,
                  width: width,
                  child: FadeInUp(
                    duration: const Duration(seconds: 1),
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/background (1).png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  height: 400,
                  width: width + 20,
                  child: FadeInUp(
                    duration: const Duration(milliseconds: 1000),
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/background-2.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // আসল UI content
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 350),
                const Text(
                  "Choose Your Role",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(30),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(40)),
                    ),
                    child: Column(
                      children: [
                        RoleButton(
                          icon: Icons.person,
                          text: "User",
                          color: Colors.deepPurple,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => UserLoginScreen()),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        RoleButton(
                          icon: Icons.engineering,
                          text: "Service Provider",
                          color: Colors.deepPurple,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const ProviderLoginScreen()),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        RoleButton(
                          icon: Icons.admin_panel_settings,
                          text: "Admin",
                          color: Colors.deepPurple,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const AdminLoginScreen()),
                            );
                          },
                        ),

                        // Uncomment for provider option
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RoleButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final VoidCallback onTap;

  const RoleButton({
    super.key,
    required this.icon,
    required this.text,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: color.withOpacity(0.1),
          border: Border.all(color: color),
        ),
        child: Row(
          children: [
            Icon(icon, size: 30, color: color),
            const SizedBox(width: 20),
            Text(
              text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios, size: 20, color: color),
          ],
        ),
      ),
    );
  }
}
