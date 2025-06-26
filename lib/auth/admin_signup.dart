// import 'package:flutter/material.dart';
// import 'package:animate_do/animate_do.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// import '../dashboard/admin_dashboard.dart';
// import 'auth_service (1).dart';
//
// class AdminSignupScreen extends StatefulWidget {
//   const AdminSignupScreen({super.key});
//
//   @override
//   _AdminSignupScreenState createState() => _AdminSignupScreenState();
// }
//
// class _AdminSignupScreenState extends State<AdminSignupScreen> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController =
//       TextEditingController();
//
//   bool _isLoading = false;
//
//   @override
//   void dispose() {
//     nameController.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//     confirmPasswordController.dispose();
//     super.dispose();
//   }
//
//   void _signup() async {
//     if (passwordController.text.trim() !=
//         confirmPasswordController.text.trim()) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Passwords do not match')),
//       );
//       return;
//     }
//
//     setState(() {
//       _isLoading = true;
//     });
//
//     User? user = await AuthService().createUserWithEmailAndPassword(
//       emailController.text.trim(),
//       passwordController.text.trim(),
//       nameController.text.trim(),
//       'admin', // Role set to admin
//     );
//
//     setState(() {
//       _isLoading = false;
//     });
//
//     if (user != null && mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Admin signup successful!')),
//       );
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const AdminDashboard()),
//       );
//     } else {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Signup failed. Try again.')),
//         );
//       }
//     }
//   }
//
//   Widget _buildTextField(
//       TextEditingController controller, String hint, bool isPassword) {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
//       ),
//       child: TextField(
//         controller: controller,
//         obscureText: isPassword,
//         decoration: InputDecoration(
//           border: InputBorder.none,
//           hintText: hint,
//           hintStyle: TextStyle(color: Colors.grey.shade700),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               height: 400,
//               child: Stack(
//                 children: [
//                   Positioned(
//                     top: -40,
//                     height: 400,
//                     width: width,
//                     child: FadeInUp(
//                       duration: const Duration(seconds: 1),
//                       child: Container(
//                         decoration: const BoxDecoration(
//                           image: DecorationImage(
//                             image:
//                                 AssetImage('assets/images/background (1).png'),
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     height: 400,
//                     width: width + 20,
//                     child: FadeInUp(
//                       duration: const Duration(milliseconds: 1000),
//                       child: Container(
//                         decoration: const BoxDecoration(
//                           image: DecorationImage(
//                             image: AssetImage('assets/images/background-2.png'),
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   FadeInUp(
//                     duration: const Duration(milliseconds: 1500),
//                     child: const Text(
//                       "Admin Sign Up",
//                       style: TextStyle(
//                         color: Color.fromRGBO(49, 39, 79, 1),
//                         fontWeight: FontWeight.bold,
//                         fontSize: 30,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   FadeInUp(
//                     duration: const Duration(milliseconds: 1700),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: Colors.white,
//                         border: Border.all(
//                             color: const Color.fromRGBO(196, 135, 198, .3)),
//                         boxShadow: const [
//                           BoxShadow(
//                             color: Color.fromRGBO(196, 135, 198, .3),
//                             blurRadius: 20,
//                             offset: Offset(0, 10),
//                           )
//                         ],
//                       ),
//                       child: Column(
//                         children: [
//                           _buildTextField(nameController, "Name", false),
//                           _buildTextField(emailController, "Email", false),
//                           _buildTextField(passwordController, "Password", true),
//                           _buildTextField(confirmPasswordController,
//                               "Confirm Password", true),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   FadeInUp(
//                     duration: const Duration(milliseconds: 1900),
//                     child: MaterialButton(
//                       onPressed: _isLoading ? null : _signup,
//                       color: const Color.fromRGBO(49, 39, 79, 1),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(50)),
//                       height: 40,
//                       child: _isLoading
//                           ? const CircularProgressIndicator(color: Colors.white)
//                           : const Text(
//                               "Sign Up",
//                               style: TextStyle(color: Colors.white),
//                             ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
