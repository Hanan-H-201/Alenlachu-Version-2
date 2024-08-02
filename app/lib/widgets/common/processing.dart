import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Processing extends StatelessWidget {
  const Processing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LottieBuilder.asset(
          'assets/animations/processing.json',
          height: 200,
          width: 200,
        ),
      ),
    );
  }
}
