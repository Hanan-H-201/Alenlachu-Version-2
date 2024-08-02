import 'package:app/controllers/common/authentication/authentication_cubit.dart';
import 'package:app/controllers/common/authentication/authentication_state.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/screens/professionals_screens/main/professional_home_screen.dart';
import 'package:app/widgets/professionals/auth/professional_signup_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfessionalSignupScreen extends StatefulWidget {
  const ProfessionalSignupScreen({super.key});

  @override
  State<ProfessionalSignupScreen> createState() =>
      _ProfessionalSignupScreenState();
}

class _ProfessionalSignupScreenState extends State<ProfessionalSignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticatedAsProfessional) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ProfessionalHomeScreen(name: state.profession.name)),
              (Route<dynamic> route) => false,
            );
          } else if (state is UnauthenticatedProfessional) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 20, top: 50, bottom: 20),
            child: Column(
              children: [
                Text(
                  'Create new Professional acount',
                  style: appTheme.textTheme.displaySmall,
                ),
                const SizedBox(
                  height: 35,
                ),
                const ProfessionalSignupForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
