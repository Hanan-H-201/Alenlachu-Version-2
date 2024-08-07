import 'package:app/controllers/common/authentication/authentication_cubit.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/widgets/common/anonymous_request.dart';
import 'package:app/widgets/common/custome_form_components.dart';
import 'package:app/widgets/common/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientLoginForm extends StatefulWidget {
  const ClientLoginForm({super.key});

  @override
  State<ClientLoginForm> createState() => _ClientLoginFormState();
}

class _ClientLoginFormState extends State<ClientLoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
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
            _usernameController,
            Text(
              'Username',
              style: appTheme.textTheme.bodyMedium,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your username';
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
          const SizedBox(height: 15),
          MainButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                context.read<AuthenticationCubit>().loginClient(
                    username: _usernameController.text,
                    password: _passwordController.text);
              }
            },
            child: Text(
              'Login',
              style: appTheme.textTheme.titleMedium,
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
                onTap: () async {
                  final bool? result =
                      await AnonymousRequest.showAnonymousUsageDialog(context);
                  if (result == true) {
                    Navigator.pushReplacementNamed(
                        // ignore: use_build_context_synchronously
                        context,
                        '/clientAnonymousRegistration');
                  } else if (result == false) {
                    Navigator.pushReplacementNamed(
                        // ignore: use_build_context_synchronously
                        context,
                        '/clientRegistration');
                  } else {
                    return;
                  }
                },
                child: Text(
                  'Sign Up',
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
