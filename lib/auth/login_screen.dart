// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:service/auth/user_signup_screen.dart';
//
// import '../pages/start.dart';
// import '../widgets/button.dart';
// import '../widgets/textfield.dart';
// import 'auth_service (1).dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final _auth = AuthService();
//
//   final _email = TextEditingController();
//   final _password = TextEditingController();
//
//   @override
//   void dispose() {
//     super.dispose();
//     _email.dispose();
//     _password.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 25),
//         child: Column(
//           children: [
//             const Spacer(),
//             const Text("Login",
//                 style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500)),
//             const SizedBox(height: 50),
//             CustomTextField(
//               hint: "Enter Email",
//               label: "Email",
//               controller: _email,
//             ),
//             const SizedBox(height: 20),
//             CustomTextField(
//               hint: "Enter Password",
//               label: "Password",
//               controller: _password,
//             ),
//             const SizedBox(height: 30),
//             CustomButton(
//               label: "Login",
//               onPressed: _login,
//             ),
//             const SizedBox(height: 5),
//             Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//               const Text("Already have an account? "),
//               InkWell(
//                 onTap: () => goToSignup(context),
//                 child:
//                     const Text("Signup", style: TextStyle(color: Colors.red)),
//               )
//             ]),
//             const Spacer()
//           ],
//         ),
//       ),
//     );
//   }
//
//   goToSignup(BuildContext context) => Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => const SignupScreen()),
//       );
//
//   goToHome(BuildContext context) => Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => const StartPage()),
//       );
//
//   _login() async {
//     final user =
//         await _auth.loginUserWithEmailAndPassword(_email.text, _password.text);
//
//     if (user != null) {
//       log("User Logged In");
//       goToHome(context);
//     }
//   }
// }
