import 'package:flutter/material.dart';

class VentingScreen extends StatelessWidget {
  const VentingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Center(
        child: Text(
          'You will be able to access the venting feature after 15 days.',
          maxLines: 10,
        ),
      ),
    );
  }
}
