import 'package:flutter/material.dart';

class AuthenticationFaildScreen extends StatelessWidget {
  final String error;
  const AuthenticationFaildScreen({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Error Occured: $error"),
      ),
    );
  }
}
