import 'package:app/controllers/common/authentication/authentication_cubit.dart';
import 'package:app/controllers/common/authentication/authentication_state.dart';
import 'package:app/core/app.dart';
import 'package:app/models/users/profession_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfessionlLandingPage extends StatelessWidget {
  const ProfessionlLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticatedAsProfessional) {
            ProfessionModel professional = state.profession;
            if (professional.verificationStatus == 'waiting') {
              return const Center(
                child: Text('Please upload license'),
              );
            } else if (professional.verificationStatus == 'pending') {
              return const Center(
                child: Text('Verification pending'),
              );
            } else if (professional.verificationStatus == 'verified') {
              return Center(
                child: Text('Welcome, ${professional.name}'),
              );
            } else if (professional.verificationStatus == 'blocked') {
              return const Center(
                child: Text('Your account has been blocked. Contact support.'),
              );
            } else {
              return const Center(
                child: Text('Unknown Status'),
              );
            }
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
