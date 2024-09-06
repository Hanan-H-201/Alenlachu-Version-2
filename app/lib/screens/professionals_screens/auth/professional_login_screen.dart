import 'package:app/controllers/common/authentication/authentication_cubit.dart';
import 'package:app/controllers/common/authentication/authentication_state.dart';
import 'package:app/core/theme/app_theme.dart';

import 'package:app/screens/professionals_screens/professionl_landing_page.dart';
import 'package:app/widgets/common/processing.dart';
import 'package:app/widgets/professionals/auth/professional_login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ProfessionalLoginScreen extends StatefulWidget {
  const ProfessionalLoginScreen({super.key});

  @override
  State<ProfessionalLoginScreen> createState() =>
      _ProfessionalLoginScreenState();
}

class _ProfessionalLoginScreenState extends State<ProfessionalLoginScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticatedAsProfessional) {
            // Navigator.of(context).push(MaterialPageRoute(
            //   builder: (context) => const VerifyOtp(),
            // ));
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const ProfessionlLandingPage()),
              (Route<dynamic> route) => false,
            );
          } else if (state is UnauthenticatedProfessional) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
              state.message,
              maxLines: 10,
            )));
          }
        },
        builder: (context, state) {
          if (state is Authenticating) {
            return const Processing();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20, top: 50, bottom: 20),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.35,
                      width: size.width,
                      child: Image.asset('assets/images/welcome.png'),
                    ),
                    Text(
                      'welcome'.tr,
                      style: appTheme.textTheme.headlineMedium,
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    const ProfessionalLoginForm(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
