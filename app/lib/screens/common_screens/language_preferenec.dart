import 'package:app/core/language/language_manager.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/screens/common_screens/registration_option_screen.dart';
import 'package:app/widgets/common/custome_form_components.dart';
import 'package:app/widgets/common/main_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LanguagePreference extends StatefulWidget {
  const LanguagePreference({super.key});

  @override
  State<LanguagePreference> createState() => _LanguagePreferenceState();
}

class _LanguagePreferenceState extends State<LanguagePreference> {
  String language = 'አማርኛ';

  void updateLanguage(String lang) {
    setState(() {
      language = lang;
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Selected language: $language')));
  }

  Future<void> updateLanguageLocale() async {
    try {
      Locale locale;
      if (language == 'English') {
        locale = const Locale('en');
      } else {
        locale = const Locale('am');
      }

      await LanguageManager.setPreferredLanguage(locale);

      // Navigate to the registration option screen after setting the language
      Get.to(() => const RegistrationOptionScreen());
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'alenilachu'.tr,
                maxLines: 2,
                style: appTheme.textTheme.headlineLarge,
              ),
              Center(
                child: LottieBuilder.asset(
                  'assets/animations/animation.json',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.4,
                ),
              ),
              Text(
                'language'.tr,
                maxLines: 2,
                style: appTheme.textTheme.headlineMedium,
              ),
              CustomFormComponents.buildDropdownInputField(
                null,
                ['አማርኛ', 'English'],
                language,
                (String? newValue) {
                  updateLanguage(newValue!);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: MainButton(
                  onPressed: updateLanguageLocale,
                  child: Text(
                    'continue'.tr,
                    style: appTheme.textTheme.titleMedium,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
