import 'package:app/controllers/common/authentication/authentication_cubit.dart';
import 'package:app/controllers/common/authentication/authentication_state.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/screens/institution_screens/main/institution_home_screen.dart';
import 'package:app/widgets/institution/auth/institution_signup_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class InstitutionSignupScreen extends StatefulWidget {
  const InstitutionSignupScreen({super.key});

  @override
  State<InstitutionSignupScreen> createState() =>
      _InstitutionSignupScreenState();
}

class _InstitutionSignupScreenState extends State<InstitutionSignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticatedAsInstitution) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      InstitutionHomeScreen(name: state.institution.name)),
              (Route<dynamic> route) => false,
            );
          } else if (state is Authenticating) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Processing. . .")));
          } else if (state is UnauthenticatedInstitution) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Unknow State")));
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 20, top: 50, bottom: 20),
            child: Column(
              children: [
                Text(
                  'let start'.tr,
                  style: appTheme.textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: 35,
                ),
                const InstitutionSignupForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
