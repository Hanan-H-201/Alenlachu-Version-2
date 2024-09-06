import 'package:app/controllers/common/authentication/authentication_cubit.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/widgets/common/custome_form_components.dart';
import 'package:app/widgets/common/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ProfessionalLoginForm extends StatefulWidget {
  const ProfessionalLoginForm({super.key});

  @override
  State<ProfessionalLoginForm> createState() => _ProfessionalLoginFormState();
}

class _ProfessionalLoginFormState extends State<ProfessionalLoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomFormComponents.buildNormalTextField(
            _phoneController,
            Text(
              '+251900000000',
              style: appTheme.textTheme.bodySmall,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          CustomFormComponents.buildPasswordField(
            _passwordController,
            Text(
              'password'.tr,
              style: appTheme.textTheme.bodyMedium,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }

              return null;
            },
          ),
          const SizedBox(height: 15),
          MainButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                context.read<AuthenticationCubit>().loginProfessional(
                    phone: _phoneController.text,
                    password: _passwordController.text);
                // context
                //     .read<PhoneAuthCubit>()
                //     .sendSMS(_phoneController.text.trim());
              }
            },
            child: Text(
              'login'.tr,
              style: appTheme.textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'haveNoAccount'.tr,
                style: appTheme.textTheme.bodyMedium,
              ),
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, '/professionalRegistration');
                },
                child: Text(
                  'signup'.tr,
                  style: appTheme.textTheme.labelMedium,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
