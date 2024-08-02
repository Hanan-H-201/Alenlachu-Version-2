import 'package:app/controllers/common/authentication/authentication_cubit.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/widgets/common/custome_form_components.dart';
import 'package:app/widgets/common/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InstitutionLoginForm extends StatefulWidget {
  const InstitutionLoginForm({super.key});

  @override
  State<InstitutionLoginForm> createState() => _InstitutionLoginFormState();
}

class _InstitutionLoginFormState extends State<InstitutionLoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
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
            _emailController,
            Text(
              'Email',
              style: appTheme.textTheme.bodySmall,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email address';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          CustomFormComponents.buildPasswordField(
            _passwordController,
            Text(
              'Password',
              style: appTheme.textTheme.bodyMedium,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }

              return null;
            },
          ),
          const SizedBox(height: 35),
          MainButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                context.read<AuthenticationCubit>().loginInstitution(
                    email: _emailController.text,
                    password: _passwordController.text);
              }
            },
            child: Text(
              'Login',
              style: appTheme.textTheme.labelLarge,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Don\'t have an account?',
                style: appTheme.textTheme.bodyMedium,
              ),
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, '/institutionRegistration');
                },
                child: Text(
                  'Sign Up',
                  style: appTheme.textTheme.titleMedium,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
