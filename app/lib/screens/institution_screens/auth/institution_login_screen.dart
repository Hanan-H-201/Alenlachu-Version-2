import 'package:flutter/material.dart';

class InstitutionLoginScreen extends StatefulWidget {
  const InstitutionLoginScreen({super.key});

  @override
  State<InstitutionLoginScreen> createState() => _InstitutionLoginScreenState();
}

class _InstitutionLoginScreenState extends State<InstitutionLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Institution Login Screen'),
      ),
    );
  }
}
