import 'package:flutter/material.dart';

class ProfessionalHomeScreen extends StatelessWidget {
  final String name;
  const ProfessionalHomeScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Welcome $name to Professionals Home Page'),
      ),
    );
  }
}
