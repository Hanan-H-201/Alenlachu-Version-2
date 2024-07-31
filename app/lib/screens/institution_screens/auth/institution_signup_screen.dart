import 'package:flutter/material.dart';

class InstitutionSignupScreen extends StatefulWidget {
  const InstitutionSignupScreen({super.key});

  @override
  State<InstitutionSignupScreen> createState() =>
      _InstitutionSignupScreenState();
}

class _InstitutionSignupScreenState extends State<InstitutionSignupScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Institution Sign Up Screen'),
      ),
    );
  }
}
