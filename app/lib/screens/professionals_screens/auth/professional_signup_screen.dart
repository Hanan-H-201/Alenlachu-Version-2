import 'package:flutter/material.dart';

class ProfessionalSignupScreen extends StatefulWidget {
  const ProfessionalSignupScreen({super.key});

  @override
  State<ProfessionalSignupScreen> createState() =>
      _ProfessionalSignupScreenState();
}

class _ProfessionalSignupScreenState extends State<ProfessionalSignupScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Professional Sign up Screen'),
      ),
    );
  }
}
