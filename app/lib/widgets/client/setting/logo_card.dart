import 'package:app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class LogoCard extends StatelessWidget {
  const LogoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: appTheme.scaffoldBackgroundColor,
          boxShadow: const [
            BoxShadow(
                blurRadius: 4,
                color: Color.fromARGB(255, 202, 202, 202),
                offset: Offset(0, 4),
                spreadRadius: 2)
          ],
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          image: const DecorationImage(
              image: AssetImage("assets/images/logo.png"), fit: BoxFit.cover)),
    );
  }
}
