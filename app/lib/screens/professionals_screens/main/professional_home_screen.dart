import 'package:app/controllers/common/authentication/authentication_cubit.dart';
import 'package:app/controllers/common/authentication/authentication_state.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/screens/common_screens/registration_option_screen.dart';
import 'package:app/widgets/common/main_button.dart';
import 'package:app/widgets/common/processing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfessionalHomeScreen extends StatelessWidget {
  final String name;
  const ProfessionalHomeScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is AppStarted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const RegistrationOptionScreen()),
              (Route<dynamic> route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is Authenticating) {
            return const Processing();
          }
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Welcome $name to Professionals Home Page'),
                const SizedBox(
                  height: 10,
                ),
                MainButton(
                    onPressed: () {
                      context.read<AuthenticationCubit>().logout();
                    },
                    child: Text(
                      'Logout',
                      style: appTheme.textTheme.titleMedium,
                    ))
              ],
            ),
          );
        },
      ),
    );
  }
}
