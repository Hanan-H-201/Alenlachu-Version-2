import 'package:app/controllers/common/authentication/authentication_cubit.dart';
import 'package:app/controllers/common/authentication/authentication_state.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/screens/admin_screens/main/home_screen.dart';
import 'package:app/widgets/admin/auth/admin_login_form.dart';
import 'package:app/widgets/common/processing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticatedAsAdmin) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => AdminHomePage(
                        email: state.admin.email,
                      )),
              (Route<dynamic> route) => false,
            );
          } else if (state is UnauthenticatedAdmin) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
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
                    const AdminLoginForm(),
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
