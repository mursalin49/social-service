import 'package:flutter/material.dart';
import 'ServiceProviderPage.dart';
// <-- এটা ঠিক path

class ElectricianPage extends StatelessWidget {
  const ElectricianPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ServiceProviderPage(
      profession: 'Electrician',
      title: 'Available Electricians',
    );
  }
}
