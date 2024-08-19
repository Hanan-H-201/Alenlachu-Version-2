import 'package:app/controllers/common/authentication/authentication_cubit.dart';
import 'package:app/controllers/common/authentication/authentication_state.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/screens/common_screens/registration_option_screen.dart';
import 'package:app/widgets/client/setting/logo_card.dart';
import 'package:app/widgets/client/setting/setting_card.dart';
import 'package:app/widgets/common/main_button.dart';
import 'package:app/widgets/common/processing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
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
          return SingleChildScrollView(
            child: Column(
              children: [
                const LogoCard(),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      const SettingCard(),
                      MainButton(
                          onPressed: () {
                            context.read<AuthenticationCubit>().logout();
                          },
                          child: Text(
                            'logout'.tr,
                            style: appTheme.textTheme.titleMedium,
                          )),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
