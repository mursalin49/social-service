import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  //  User Create with Role
  Future<User?> createUserWithEmailAndPassword(
      String email, String password, String name, String role) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (cred.user != null) {
        //  Store user data in Realtime Database with role
        await _dbRef.child("users").child(cred.user!.uid).set({
          "uid": cred.user!.uid,
          "name": name,
          "email": email,
          "role": role,
        });
        return cred.user;
      }
    } catch (e) {
      log("Signup Error: $e");
    }
    return null;
  }

  Future<User?> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return cred.user;
    } catch (e) {
      log("Login Error: $e");
    }
    return null;
  }

  //  Get Current User Role from Realtime Database
  Future<String?> getUserRole(String uid) async {
    try {
      final snapshot =
          await _dbRef.child("users").child(uid).child("role").get();
      if (snapshot.exists) {
        return snapshot.value.toString();
      }
    } catch (e) {
      log("Get Role Error: $e");
    }
    return null;
  }

  //  Sign Out
  Future<void> signout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log("Signout Error: $e");
    }
  }
}
