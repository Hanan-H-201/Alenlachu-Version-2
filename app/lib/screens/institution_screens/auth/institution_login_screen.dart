import 'package:app/controllers/common/authentication/authentication_cubit.dart';
import 'package:app/controllers/common/authentication/authentication_state.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/screens/institution_screens/main/institution_home_screen.dart';
import 'package:app/widgets/common/processing.dart';
import 'package:app/widgets/institution/auth/institution_login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InstitutionLoginScreen extends StatefulWidget {
  const InstitutionLoginScreen({super.key});

  @override
  State<InstitutionLoginScreen> createState() => _InstitutionLoginScreenState();
}

class _InstitutionLoginScreenState extends State<InstitutionLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticatedAsInstitution) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      InstitutionHomeScreen(name: state.institution.name)),
              (Route<dynamic> route) => false,
            );
          } else if (state is UnauthenticatedInstitution) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (BuildContext context, AuthenticationState state) {
          if (state is Authenticating) {
            return const Processing();
          }
          return Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 20, top: 50, bottom: 20),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Welcome Back!',
                    style: appTheme.textTheme.displayMedium,
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  const InstitutionLoginForm(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
