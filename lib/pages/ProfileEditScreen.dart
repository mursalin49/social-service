import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController availabilityController = TextEditingController();

  final dbRef = FirebaseDatabase.instance.ref();
  final uid = FirebaseAuth.instance.currentUser!.uid;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadProviderData();
  }

  Future<void> _loadProviderData() async {
    final snapshot = await dbRef.child("providers/$uid").get();
    if (snapshot.exists) {
      final data = Map<String, dynamic>.from(snapshot.value as Map);
      nameController.text = data['name'] ?? '';
      phoneController.text = data['phone'] ?? '';
      locationController.text = data['location'] ?? '';
      availabilityController.text = data['availability'] ?? '';
    }
  }

  Future<void> _saveProfile() async {
    setState(() => _isLoading = true);

    await dbRef.child("providers/$uid").set({
      "name": nameController.text.trim(),
      "phone": phoneController.text.trim(),
      "location": locationController.text.trim(),
      "availability": availabilityController.text.trim(),
      "uid": uid,
      "email": FirebaseAuth.instance.currentUser!.email,
    });

    setState(() => _isLoading = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile updated successfully")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField(nameController, "Name"),
            _buildTextField(phoneController, "Phone"),
            _buildTextField(locationController, "Location"),
            _buildTextField(
                availabilityController, "Availability Time (e.g. 9AM-5PM)"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _saveProfile,
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Save Profile"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: hint,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
