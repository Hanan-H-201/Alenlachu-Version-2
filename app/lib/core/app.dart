import 'dart:convert';

import 'package:app/controllers/client/bottom_nav/client_bottom_nav_cubit.dart';
import 'package:app/controllers/client/journal/journal_cubit.dart';
import 'package:app/controllers/common/authentication/authentication_cubit.dart';
import 'package:app/controllers/common/awareness/awareness_cubit.dart';
import 'package:app/controllers/common/event/event_cubit.dart';
import 'package:app/controllers/common/phone_auth/phone_auth_cubit.dart';
import 'package:app/controllers/professionals/professionals/professionals_cubit.dart';
import 'package:app/core/app_navigator.dart';
import 'package:app/core/language/local_strings.dart';
import 'package:app/core/login_manager.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/screens/admin_screens/auth/admin_login_screen.dart';
import 'package:app/screens/admin_screens/auth/admin_signup_screen.dart';
import 'package:app/screens/client_screens/auth/client_anonymous_registration.dart';
import 'package:app/screens/client_screens/auth/client_login_screen.dart';
import 'package:app/screens/client_screens/auth/client_signup_screen.dart';
import 'package:app/screens/institution_screens/auth/institution_login_screen.dart';
import 'package:app/screens/institution_screens/auth/institution_signup_screen.dart';
import 'package:app/screens/professionals_screens/auth/professional_login_screen.dart';
import 'package:app/screens/professionals_screens/auth/professional_signup_screen.dart';
import 'package:app/services/client/journal_services.dart';
import 'package:app/services/common/authentication_service.dart';
import 'package:app/services/common/awareness_service.dart';
import 'package:app/services/common/event_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class MainApp extends StatefulWidget {
  final Locale? lang;
  const MainApp({super.key, required this.lang});

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
    final String? token = await LoginManager.getUserToken();
    final String? role = await LoginManager.getUserRole();

    if (role != null && token != null) {
      final AuthenticationService auth = AuthenticationService();
      try {
        final response = await auth.verifyToken();
        final jsonRespone = jsonDecode(response.body);
        if (response.statusCode == 200) {
          final Map<String, dynamic>? tokenData = await auth.getUser();
          _validateCredential(tokenData!, role);
        } else {
          await LoginManager.removeToken();
          _emitError(jsonRespone['error'], role);
        }
      } catch (e) {
        _emitAuthError(e.toString());
      }
    } else if (role != null && token == null) {
      _setupLogin(role);
    } else {
      _emitAppStarted();
    }
  }

  void _emitAuthError(String error) {
    BlocProvider.of<AuthenticationCubit>(context).authenticationFaild(error);
  }

  void _emitAppStarted() {
    BlocProvider.of<AuthenticationCubit>(context).appStarted();
  }

  void _emitError(String error, String role) {
    if (role == 'client') {
      BlocProvider.of<AuthenticationCubit>(context).unAuthenticateClient(error);
    } else if (role == 'professional') {
      BlocProvider.of<AuthenticationCubit>(context)
          .unAuthenticateProfessional(error);
    } else if (role == 'institution') {
      BlocProvider.of<AuthenticationCubit>(context)
          .unAuthenticateInstitution(error);
    }
  }

  void _validateCredential(Map<String, dynamic> data, String role) {
    if (role == 'client') {
      BlocProvider.of<AuthenticationCubit>(context).authenticateClient(data);
    } else if (role == 'professional') {
      BlocProvider.of<AuthenticationCubit>(context)
          .authenticateProfessional(data);
    } else if (role == 'institution') {
      BlocProvider.of<AuthenticationCubit>(context)
          .authenticateInstitution(data);
    }
  }

  void _setupLogin(String role) {
    if (role == 'client') {
      BlocProvider.of<AuthenticationCubit>(context)
          .unAuthenticateClient('You were logged out');
    } else if (role == 'professional') {
      BlocProvider.of<AuthenticationCubit>(context)
          .unAuthenticateProfessional('You were logged out');
    } else if (role == 'institution') {
      BlocProvider.of<AuthenticationCubit>(context)
          .unAuthenticateInstitution('You were logged out');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ClientBottomNavCubit()),
        BlocProvider(
            create: (context) =>
                AwarenessCubit(awarenessService: AwarenessService())),
        BlocProvider(
            create: (context) => EventCubit(eventServices: EventServices())),
        BlocProvider(create: (context) => ProfessionalsCubit()),
        // BlocProvider(create: (context) => PhoneAuthCubit()),
        BlocProvider(
            create: (context) => JournalCubit(
                journalServices: JournalServices(),
                authenticationCubit:
                    BlocProvider.of<AuthenticationCubit>(context)))
      ],
      child: GetMaterialApp(
        title: 'Alenlachu',
        theme: appTheme,
        translations: LocalString(),
        locale: widget.lang ?? const Locale('am'),
        routes: {
          '/clientRegistration': (context) => const ClientSignupScreen(),
          '/clientAnonymousRegistration': (context) =>
              const ClientAnonymousRegistration(),
          '/clientLogin': (context) => const ClientLoginScreen(),
          '/adminRegistration': (context) => const AdminSignupScreen(),
          '/adminLogin': (context) => const AdminLoginScreen(),
          '/institutionRegistration': (context) =>
              const InstitutionSignupScreen(),
          '/InstitutionLogin': (context) => const InstitutionLoginScreen(),
          '/professionalRegistration': (context) =>
              const ProfessionalSignupScreen(),
          '/professionalLogin': (context) => const ProfessionalLoginScreen(),
        },
        home: const AppNavigator(),
      ),
    );
  }
}
