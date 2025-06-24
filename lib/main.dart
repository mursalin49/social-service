import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:service/pages/selection_screen.dart';
import 'package:service/profile/HridoyProfile.dart';
import 'package:service/profile/OmairProfile.dart';
import 'package:service/profile/TasniaProfile.dart';
import 'package:service/profile/profile_page.dart';
import 'auth/admin_login.dart';
import 'auth/provider_login.dart';
import 'auth/user_login_screen.dart';
import 'dashboard/provider_dashboard.dart';
import 'firebase_options.dart';
import 'auth/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("✅ Firebase Initialized Successfully");
  } catch (e) {
    print("❌ Firebase initialization error: $e");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Service App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/role',
      routes: {
        '/role': (context) => const SelectionScreen(),
        '/admin_login': (context) => const AdminLoginScreen(),
        '/user_login': (context) => UserLoginScreen(),
        '/provider_login': (context) => const ProviderLoginScreen(),
        '/provider_dashboard': (context) => const ProviderDashboard(),
        '/profile': (context) => const ProfilePage(),
        '/hridoy': (context) => const HridoyProfile(),
        '/omair': (context) => const OmairProfile(),
        '/tasnia': (context) => const TasniaProfile(),
      },
    );
  }
}
