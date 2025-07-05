import 'package:flutter/material.dart';
import 'ServiceProviderPage.dart';

class CookerPage extends StatelessWidget {
  const CookerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ServiceProviderPage(
      profession: 'Cooker',
      title: 'Available Cookers',
    );
  }
}
