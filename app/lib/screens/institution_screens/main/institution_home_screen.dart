import 'package:flutter/material.dart';

class InstitutionHomeScreen extends StatelessWidget {
  final String name;
  const InstitutionHomeScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Welcome $name to Institution Home Page'),
      ),
    );
  }
}
