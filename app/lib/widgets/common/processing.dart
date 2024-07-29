import 'package:flutter/material.dart';

class Processing extends StatelessWidget {
  const Processing({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
