import 'package:flutter/material.dart';

class ClientHomeScreen extends StatelessWidget {
  final String username;
  const ClientHomeScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Welcome $username to Client Home Page'),
      ),
    );
  }
}
