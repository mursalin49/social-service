import 'package:flutter/material.dart';
import 'ServiceProviderPage.dart';

class DriverPage extends StatelessWidget {
  const DriverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ServiceProviderPage(
      profession: 'Driver',
      title: 'Available Drivers',
    );
  }
}
