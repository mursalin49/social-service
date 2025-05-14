// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'auth/login_screen.dart';
// import 'firebase_options.dart';
//
// void main() async {
//   WidgetsFlutterBinding
//       .ensureInitialized(); // Make sure widgets are initialized before Firebase
//   try {
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//     print("Firebase Initialized");
//   } catch (e) {
//     print("Firebase initialization error: $e");
//   }
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: LoginScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:service/profile/HridoyProfile.dart';
import 'package:service/profile/OmairProfile.dart';
import 'package:service/profile/TasniaProfile.dart';
import 'package:service/profile/profile_page.dart';
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
      home: const LoginScreen(),
      routes: {
        '/profile': (context) => const ProfilePage(),
        '/hridoy': (context) => const HridoyProfile(),
        '/omair': (context) => const OmairProfile(),
        '/tasnia': (context) => const TasniaProfile(),
      },
    );
  }
}
