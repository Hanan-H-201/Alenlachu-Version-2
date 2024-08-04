import 'package:app/controllers/common/authentication/authentication_cubit.dart';
import 'package:app/controllers/common/authentication/authentication_state.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/screens/common_screens/registration_option_screen.dart';
import 'package:app/widgets/common/main_button.dart';
import 'package:app/widgets/common/processing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

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
        builder: (BuildContext context, AuthenticationState state) {
          if (state is Authenticating) {
            return const Processing();
          }
          return Center(
            child: MainButton(
                onPressed: () {
                  context.read<AuthenticationCubit>().logout();
                },
                child: Text(
                  'Logout',
                  style: appTheme.textTheme.titleMedium,
                )),
          );
        },
      ),
    );
  }
}
