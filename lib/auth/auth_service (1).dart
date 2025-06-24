import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e) {
      log("Something went wrong");
    }
    return null;
  }

  Future<User?> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e) {
      log("Something went wrong");
    }
    return null;
  }

  Future<void> signout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log("Something went wrong");
    }
  }
}
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
//
// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final DatabaseReference _dbRef =
//       FirebaseDatabase.instance.ref().child('users');
//
//   // Signup with Email & Password and save role to Realtime Database
//   Future<User?> signupUserWithEmailAndPassword({
//     required String name,
//     required String email,
//     required String password,
//     required String role, // 'user', 'provider', 'admin'
//   }) async {
//     try {
//       UserCredential userCredential =
//           await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//
//       User? user = userCredential.user;
//       if (user != null) {
//         await _dbRef.child(user.uid).set({
//           'name': name,
//           'email': email,
//           'role': role,
//         });
//         return user;
//       }
//     } catch (e) {
//       print('Signup Error: $e');
//     }
//     return null;
//   }
//
//   // Login with Email & Password
//   Future<User?> loginUserWithEmailAndPassword(
//       String email, String password) async {
//     try {
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return userCredential.user;
//     } catch (e) {
//       print('Login Error: $e');
//       return null;
//     }
//   }
//
//   // Get current user role from Realtime Database
//   Future<String?> getUserRole(String uid) async {
//     try {
//       final snapshot = await _dbRef.child(uid).get();
//       if (snapshot.exists) {
//         final data = Map<String, dynamic>.from(snapshot.value as dynamic);
//         return data['role'] ?? null;
//       }
//     } catch (e) {
//       print('Role fetch error: $e');
//     }
//     return null;
//   }
//
//   // Sign out
//   Future<void> signOut() async {
//     await _auth.signOut();
//   }
// }
