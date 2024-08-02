import 'package:app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final Widget child;
  final void Function()? onPressed;
  const MainButton({super.key, required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
            gradient: containerGradient,
            borderRadius: BorderRadius.circular(10)),
        child: Center(child: child),
      ),
    );
  }
}
