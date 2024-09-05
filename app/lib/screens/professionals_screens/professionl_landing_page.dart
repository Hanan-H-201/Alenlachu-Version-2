import 'package:app/controllers/common/authentication/authentication_cubit.dart';
import 'package:app/controllers/common/authentication/authentication_state.dart';
import 'package:app/controllers/professionals/professionals/professionals_cubit.dart';
import 'package:app/controllers/professionals/professionals/professionals_state.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/models/users/profession_model.dart';
import 'package:app/screens/common_screens/language_preferenec.dart';
import 'package:app/widgets/common/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

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
              return Center(
                child: BlocBuilder<ProfessionalsCubit, ProfessionalsState>(
                  builder: (context, state) {
                    if (state is ProfessionalsInitial) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Please upload license'),
                          MainButton(
                              onPressed: () {
                                context.read<ProfessionalsCubit>().uploadFile();
                              },
                              child: Text(
                                'prof_l_upload'.tr,
                                style: appTheme.textTheme.titleMedium,
                              )),
                        ],
                      );
                    } else if (state is UploadindLicense) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is LicenseUploaded) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          state.file != null
                              ? state.filename!.endsWith('.pdf')
                                  ? const Icon(Icons.picture_as_pdf, size: 100)
                                  : Image.file(state.file!, height: 150)
                              : const Text('No file selected'),
                          const SizedBox(height: 20),
                          MainButton(
                              onPressed: () {
                                context.read<ProfessionalsCubit>().saveFile(
                                    state.file,
                                    state.filename,
                                    professional.id!);
                              },
                              child: state is UploadindLicense
                                  ? const CircularProgressIndicator()
                                  : Text(
                                      'save'.tr,
                                      style: appTheme.textTheme.titleMedium,
                                    ))
                        ],
                      );
                    } else if (state is ProcessingData) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Data saved successfully! we will verify the Data and send you the response soon. Stay Safe!',
                              maxLines: 10,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            MainButton(
                                onPressed: () {
                                  context.read<AuthenticationCubit>().logout();
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LanguagePreference()),
                                    (Route<dynamic> route) => false,
                                  );
                                },
                                child: Text(
                                  'logout'.tr,
                                  style: appTheme.textTheme.titleMedium,
                                )),
                          ],
                        ),
                      );
                    } else if (state is LicenseUploadFailed) {
                      return Center(
                        child: Text(
                          'License upload failed: ${state.error}',
                          maxLines: 10,
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text('Unknown Status'),
                      );
                    }
                  },
                ),
              );
            } else if (professional.verificationStatus == 'pending') {
              return Center(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('We are verifying your data. stay tuned!'),
                    const SizedBox(height: 20),
                    MainButton(
                        onPressed: () {
                          context.read<AuthenticationCubit>().logout();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const LanguagePreference()),
                            (Route<dynamic> route) => false,
                          );
                        },
                        child: Text(
                          'logout'.tr,
                          style: appTheme.textTheme.titleMedium,
                        )),
                  ],
                ),
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
