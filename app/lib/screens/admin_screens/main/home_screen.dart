import 'package:flutter/material.dart';

class AdminHomePage extends StatelessWidget {
  final String email;
  const AdminHomePage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('welcome $email to Admin Home Page'),
      ),
    );
  }
}
