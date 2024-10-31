import 'package:app/controllers/common/authentication/authentication_cubit.dart';
import 'package:app/controllers/common/authentication/authentication_state.dart';
import 'package:app/screens/client_screens/auth/client_login_screen.dart';
import 'package:app/screens/client_screens/client_landing_page.dart';
import 'package:app/screens/common_screens/authentication_faild.dart';
import 'package:app/screens/common_screens/language_preferenec.dart';
import 'package:app/screens/institution_screens/auth/institution_login_screen.dart';
import 'package:app/screens/institution_screens/main/institution_home_screen.dart';
import 'package:app/screens/professionals_screens/auth/professional_login_screen.dart';
import 'package:app/screens/professionals_screens/professionl_landing_page.dart';
import 'package:app/widgets/common/processing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (BuildContext context, AuthenticationState state) {
      if (state is AppStarted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("We are happy that you are here!")));
      } else if (state is UnauthenticatedClient) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.message)));
      } else if (state is UnauthenticatedInstitution) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.message)));
      } else if (state is UnauthenticatedProfessional) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.message)));
      } else if (state is AuthenticatedAsClient) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Welcome Home ${state.client.username}")));
      } else if (state is AuthenticatedAsInstitution) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Welcome Home ${state.institution.name}")));
      } else if (state is AuthenticatedAsProfessional) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Welcome Home ${state.profession.name}")));
      }
    }, builder: (context, state) {
      if (state is AppStarted) {
        return const LanguagePreference();
        // return const RegistrationOptionScreen();
      } else if (state is UnauthenticatedClient) {
        return const ClientLoginScreen();
      } else if (state is UnauthenticatedInstitution) {
        return const InstitutionLoginScreen();
      } else if (state is UnauthenticatedProfessional) {
        return const ProfessionalLoginScreen();
      } else if (state is AuthenticatedAsClient) {
        return const ClientLandingPage();
      } else if (state is AuthenticatedAsInstitution) {
        return InstitutionHomeScreen(name: state.institution.name);
      } else if (state is AuthenticatedAsProfessional) {
        return const ProfessionlLandingPage();
      } else if (state is AuthenticationFailed) {
        return AuthenticationFaildScreen(
          error: state.errorMessage,
        );
      } else if (state is Authenticating) {
        return const Processing();
      } else if (state is AppInitial) {
        return const Processing();
      } else {
        return const LanguagePreference();
      }
    });
  }
}
