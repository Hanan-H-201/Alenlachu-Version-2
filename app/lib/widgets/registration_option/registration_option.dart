import 'package:app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class RegistrationOptionCard extends StatelessWidget {
  const RegistrationOptionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          buildOption(context, 'As a Client', () {
            Navigator.pushNamed(context, '/clientRegistration');
          }),
          const SizedBox(
            height: 10,
          ),
          buildOption(context, 'As a Professional', () {
            Navigator.pushNamed(context, '/professionalRegistration');
          }),
          const SizedBox(
            height: 10,
          ),
          buildOption(context, 'As an Institution', () {
            Navigator.pushNamed(context, '/institutionRegistration');
          }),
          const SizedBox(
            height: 10,
          ),
          buildOption(context, 'As an Admin', () {
            Navigator.pushNamed(context, '/adminRegistration');
          }),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget buildOption(
      BuildContext context, String lable, void Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            gradient: containerGradient,
            boxShadow: const [
              BoxShadow(
                  color: Color.fromARGB(255, 200, 200, 200),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 4))
            ]),
        child: Center(
          child: Text(
            lable,
            style: appTheme.textTheme.labelMedium,
          ),
        ),
      ),
    );
  }
}
