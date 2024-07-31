import 'package:app/core/theme/app_theme.dart';
import 'package:app/widgets/registration_option/registration_option.dart';
import 'package:flutter/material.dart';

class RegistrationOptionScreen extends StatefulWidget {
  const RegistrationOptionScreen({super.key});

  @override
  State<RegistrationOptionScreen> createState() =>
      _RegistrationOptionScreenState();
}

class _RegistrationOptionScreenState extends State<RegistrationOptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'How would you like continue using the App?',
              style: appTheme.textTheme.displaySmall,
            ),
            const SizedBox(
              height: 20,
            ),
            const RegistrationOptionCard(),
          ],
        ),
      ),
    ));
  }
}
