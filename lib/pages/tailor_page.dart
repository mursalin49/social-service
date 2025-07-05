import 'package:flutter/material.dart';
import 'ServiceProviderPage.dart';

class TailorPage extends StatelessWidget {
  const TailorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ServiceProviderPage(
      profession: 'Tailor',
      title: 'Available Tailors',
    );
  }
}
