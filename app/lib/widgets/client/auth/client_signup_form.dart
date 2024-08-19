import 'package:app/controllers/common/authentication/authentication_cubit.dart';
import 'package:app/controllers/common/authentication/authentication_state.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/widgets/common/custome_form_components.dart';
import 'package:app/widgets/common/main_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ClientSignupForm extends StatefulWidget {
  const ClientSignupForm({super.key});

  @override
  State<ClientSignupForm> createState() => _ClientSignupFormState();
}

class _ClientSignupFormState extends State<ClientSignupForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _residenceController = TextEditingController();
  final TextEditingController _emergencyContactController =
      TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  String selectedCountryCode = '+251';

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneNumberController.dispose();
    _dateOfBirthController.dispose();
    _nationalityController.dispose();
    _residenceController.dispose();
    _emergencyContactController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: CustomFormComponents.buildNormalTextField(
                  _fullNameController,
                  Text(
                    'fullname'.tr,
                    style: appTheme.textTheme.bodyMedium,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'required'.tr;
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: CustomFormComponents.buildNormalTextField(
                  _usernameController,
                  Text(
                    'username'.tr,
                    style: appTheme.textTheme.bodyMedium,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'required'.tr;
                    }
                    return null;
                  },
                ),
              ),
            ],
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
                return 'required'.tr;
              }

              return null;
            },
          ),
          const SizedBox(height: 15),
          CustomFormComponents.buildPasswordField(
            _confirmPasswordController,
            Text(
              'confirm'.tr,
              style: appTheme.textTheme.bodyMedium,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'required'.tr;
              }
              if (value != _passwordController.text.trim()) {
                return 'confirmError'.tr;
              }

              return null;
            },
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: CustomFormComponents.buildNormalTextField(
                  _emailController,
                  Text(
                    'email'.tr,
                    style: appTheme.textTheme.bodyMedium,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'required'.tr;
                    }

                    return null;
                  },
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: CustomFormComponents.buildDatePickerField(
                  context,
                  _dateOfBirthController,
                  Text(
                    'birthDate'.tr,
                    style: appTheme.textTheme.bodyMedium,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'required'.tr;
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          CustomFormComponents.buildPhoneNumberField(
            _phoneNumberController,
            Text(
              'phone'.tr,
              style: appTheme.textTheme.bodyMedium,
            ),
            selectedCountryCode,
            ['+1', '+2', '+251', '+19', '+23'],
            (String? newValue) {
              setState(() {
                selectedCountryCode = newValue ?? '+251';
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'required'.tr;
              }

              return null;
            },
          ),
          const SizedBox(height: 15),
          CustomFormComponents.buildPhoneNumberField(
            _emergencyContactController,
            Text(
              'emergency'.tr,
              style: appTheme.textTheme.bodyMedium,
            ),
            selectedCountryCode,
            ['+1', '+2', '+251', '+19', '+23'],
            (String? newValue) {
              setState(() {
                selectedCountryCode = newValue ?? '+251';
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'required'.tr;
              }

              return null;
            },
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: CustomFormComponents.buildDropdownInputField(
                  Text(
                    'residency'.tr,
                    style: appTheme.textTheme.bodyMedium,
                  ),
                  ['Ethiopia', 'USA', 'Kenya', 'Sudan', 'Germany'],
                  "Ethiopia",
                  (String? newValue) {
                    setState(() {
                      _residenceController.text = newValue ?? "";
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'required'.tr;
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: CustomFormComponents.buildDropdownInputField(
                  Text(
                    'nationality'.tr,
                    style: appTheme.textTheme.bodyMedium,
                  ),
                  ['Ethiopia', 'USA', 'Kenya', 'Sudan', 'Germany'],
                  "Ethiopia",
                  (String? newValue) {
                    setState(() {
                      _nationalityController.text = newValue ?? '';
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'required'.tr;
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          BlocBuilder<AuthenticationCubit, AuthenticationState>(
            builder: (context, state) {
              return MainButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    context.read<AuthenticationCubit>().registerClient(
                        username: _usernameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                        emergencyContact:
                            '$selectedCountryCode${_emergencyContactController.text}',
                        isAnonymous: false,
                        fullName: _fullNameController.text,
                        phoneNumber:
                            '$selectedCountryCode${_phoneNumberController.text}',
                        dateOfBirth:
                            DateTime.parse(_dateOfBirthController.text),
                        nationality: _nationalityController.text,
                        residency: _residenceController.text);
                  }
                },
                child: state is Authenticating
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text(
                        'signup'.tr,
                        style: appTheme.textTheme.titleMedium,
                      ),
              );
            },
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'haveAccount'.tr,
                style: appTheme.textTheme.bodyMedium,
              ),
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/clientLogin');
                },
                child: Text(
                  'login'.tr,
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
