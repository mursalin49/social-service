// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
//
// class ProfileEditScreen extends StatefulWidget {
//   const ProfileEditScreen({super.key});
//
//   @override
//   State<ProfileEditScreen> createState() => _ProfileEditScreenState();
// }
//
// class _ProfileEditScreenState extends State<ProfileEditScreen> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController locationController = TextEditingController();
//   final TextEditingController availabilityController = TextEditingController();
//
//   final dbRef = FirebaseDatabase.instance.ref();
//   final uid = FirebaseAuth.instance.currentUser!.uid;
//
//   bool _isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadProviderData();
//   }
//
//   Future<void> _loadProviderData() async {
//     final snapshot = await dbRef.child("providers/$uid").get();
//     if (snapshot.exists) {
//       final data = Map<String, dynamic>.from(snapshot.value as Map);
//       nameController.text = data['name'] ?? '';
//       phoneController.text = data['phone'] ?? '';
//       locationController.text = data['location'] ?? '';
//       availabilityController.text = data['availability'] ?? '';
//     }
//   }
//
//   Future<void> _saveProfile() async {
//     setState(() => _isLoading = true);
//
//     await dbRef.child("providers/$uid").set({
//       "name": nameController.text.trim(),
//       "phone": phoneController.text.trim(),
//       "location": locationController.text.trim(),
//       "availability": availabilityController.text.trim(),
//       "uid": uid,
//       "email": FirebaseAuth.instance.currentUser!.email,
//     });
//
//     setState(() => _isLoading = false);
//
//     if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Profile updated successfully")),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Edit Profile"),
//         backgroundColor: Colors.deepPurple,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             _buildTextField(nameController, "Name"),
//             _buildTextField(phoneController, "Phone"),
//             _buildTextField(locationController, "Location"),
//             _buildTextField(
//                 availabilityController, "Availability Time (e.g. 9AM-5PM)"),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _isLoading ? null : _saveProfile,
//               style:
//                   ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
//               child: _isLoading
//                   ? const CircularProgressIndicator(color: Colors.white)
//                   : const Text("Save Profile"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField(TextEditingController controller, String hint) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12.0),
//       child: TextField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: hint,
//           border: const OutlineInputBorder(),
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

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
  String? selectedProfession = 'Cleaner';
  String? imageUrl;
  File? _imageFile;

  final List<String> professions = [
    'Cleaner',
    'Electrician',
    'Tailor',
    'Driver',
    'Caretaker',
    'Cooker',
  ];

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
      selectedProfession = data['profession'] ?? 'Cleaner';
      imageUrl = data['image'];
      setState(() {});
    }
  }

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  Future<String?> _uploadImage() async {
    if (_imageFile == null) return imageUrl; // keep previous or null
    final ref = FirebaseStorage.instance.ref().child('profile_images/$uid.jpg');
    await ref.putFile(_imageFile!);
    return await ref.getDownloadURL();
  }

  Future<void> _saveProfile() async {
    setState(() => _isLoading = true);

    final uploadedImageUrl = await _uploadImage();

    await dbRef.child("providers/$uid").set({
      "uid": uid,
      "email": FirebaseAuth.instance.currentUser!.email,
      "name": nameController.text.trim(),
      "phone": phoneController.text.trim(),
      "location": locationController.text.trim(),
      "availability": availabilityController.text.trim(),
      "profession": selectedProfession,
      "role": "provider",
      "image": uploadedImageUrl ?? "", // Optional image
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 📸 Profile Picture Preview
              CircleAvatar(
                radius: 50,
                backgroundImage: _imageFile != null
                    ? FileImage(_imageFile!)
                    : imageUrl != null && imageUrl!.isNotEmpty
                        ? NetworkImage(imageUrl!)
                        : const AssetImage('assets/default_profile.png')
                            as ImageProvider,
              ),
              TextButton(
                onPressed: _pickImage,
                child: const Text("Choose Profile Image"),
              ),

              const SizedBox(height: 10),
              _buildTextField(nameController, "Name"),
              _buildTextField(phoneController, "Phone"),
              _buildTextField(locationController, "Location"),
              _buildTextField(
                  availabilityController, "Availability Time (e.g. 9AM-5PM)"),
              const SizedBox(height: 10),
              _buildProfessionDropdown(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _saveProfile,
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.black12),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Save Profile"),
              ),
            ],
          ),
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

  Widget _buildProfessionDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedProfession,
      decoration: const InputDecoration(
        labelText: "Profession",
        border: OutlineInputBorder(),
      ),
      items: professions
          .map((profession) => DropdownMenuItem(
                value: profession,
                child: Text(profession),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedProfession = value;
        });
      },
    );
  }
}
