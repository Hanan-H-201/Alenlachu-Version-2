import 'dart:convert';

import 'package:app/controllers/common/authentication/authentication_cubit.dart';
import 'package:app/controllers/common/authentication/authentication_state.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/screens/admin_screens/auth/admin_login_screen.dart';
import 'package:app/screens/admin_screens/auth/admin_signup_screen.dart';
import 'package:app/screens/client_screens/auth/client_login_screen.dart';
import 'package:app/screens/client_screens/auth/client_signup_screen.dart';
import 'package:app/screens/client_screens/main/client_home_screen.dart';
import 'package:app/screens/common_screens/registration_option_screen.dart';
import 'package:app/screens/institution_screens/auth/institution_login_screen.dart';
import 'package:app/screens/institution_screens/auth/institution_signup_screen.dart';
import 'package:app/screens/institution_screens/main/institution_home_screen.dart';
import 'package:app/screens/professionals_screens/auth/professional_login_screen.dart';
import 'package:app/screens/professionals_screens/auth/professional_signup_screen.dart';
import 'package:app/screens/professionals_screens/main/professional_home_screen.dart';
import 'package:app/services/common/authentication_service.dart';
import 'package:app/widgets/common/processing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

class MainApp extends StatefulWidget {
  final String? role;
  final String? token;
  const MainApp({
    super.key,
    required this.role,
    required this.token,
  });

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    if (widget.role != null && widget.token != null) {
      final AuthenticationService auth = AuthenticationService();
      final response = await auth.verifyToken();
      final tokenData = await auth.getUser();
      if (tokenData != null) {
        _validateCredential(response, tokenData);
      }
    } else if (widget.role != null && widget.token == null) {
      _setupLogin();
    }
  }

  void _validateCredential(Response response, Map<String, dynamic> data) {
    if (widget.role == 'client') {
      if (response.statusCode != 200) {
        final String errorMessage = jsonDecode(response.body);
        BlocProvider.of<AuthenticationCubit>(context)
            .unAuthenticateClient(errorMessage);
        return;
      }

      BlocProvider.of<AuthenticationCubit>(context)
          .loginClient(username: data["username"], password: data["password"]);
    } else if (widget.role == 'professional') {
      if (response.statusCode != 200) {
        final String errorMessage = jsonDecode(response.body);
        BlocProvider.of<AuthenticationCubit>(context)
            .unAuthenticateProfessional(errorMessage);
        return;
      }

      BlocProvider.of<AuthenticationCubit>(context)
          .loginProfessional(email: data["email"], password: data["password"]);
    } else if (widget.role == 'institution') {
      if (response.statusCode != 200) {
        final String errorMessage = jsonDecode(response.body);
        BlocProvider.of<AuthenticationCubit>(context)
            .unAuthenticateInstitution(errorMessage);
        return;
      }

      BlocProvider.of<AuthenticationCubit>(context)
          .loginInstitution(email: data["email"], password: data["password"]);
    }
  }

  void _setupLogin() {
    if (widget.role == 'client') {
      BlocProvider.of<AuthenticationCubit>(context)
          .unAuthenticateClient('You were logged out');
    } else if (widget.role == 'professional') {
      BlocProvider.of<AuthenticationCubit>(context)
          .unAuthenticateProfessional('You were logged out');
    } else if (widget.role == 'institution') {
      BlocProvider.of<AuthenticationCubit>(context)
          .unAuthenticateInstitution('You were logged out');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alenlachu',
      theme: appTheme,
      routes: {
        '/clientRegistration': (context) => const ClientSignupScreen(),
        '/clientLogin': (context) => const ClientLoginScreen(),
        '/adminRegistration': (context) => const AdminSignupScreen(),
        '/adminLogin': (context) => const AdminLoginScreen(),
        '/institutionRegistration': (context) =>
            const InstitutionSignupScreen(),
        '/InstitutionLogin': (context) => const InstitutionLoginScreen(),
        '/professionalRegistration': (context) =>
            const ProfessionalSignupScreen(),
        '/professionalLogin': (context) => const ProfessionalLoginScreen()
      },
      home: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, state) {
          if (state is AppStarted) {
            return const RegistrationOptionScreen();
          } else if (state is UnauthenticatedClient) {
            return const ClientLoginScreen();
          } else if (state is UnauthenticatedInstitution) {
            return const InstitutionLoginScreen();
          } else if (state is UnauthenticatedProfessional) {
            return const ProfessionalLoginScreen();
          } else if (state is AuthenticatedAsClient) {
            return ClientHomeScreen(
              username: state.client.username,
            );
          } else if (state is AuthenticatedAsInstitution) {
            return InstitutionHomeScreen(name: state.institution.name);
          } else if (state is AuthenticatedAsProfessional) {
            return ProfessionalHomeScreen(
              name: state.profession.name,
            );
          } else if (state is Authenticating) {
            return const Processing();
          } else {
            return const RegistrationOptionScreen();
          }
        },
      ),
    );
  }
}
