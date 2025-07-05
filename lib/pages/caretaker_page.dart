import 'package:flutter/material.dart';
import 'ServiceProviderPage.dart';

class CaretakerPage extends StatelessWidget {
  const CaretakerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ServiceProviderPage(
      profession: 'Caretaker',
      title: 'Available Caretakers',
    );
  }
}
