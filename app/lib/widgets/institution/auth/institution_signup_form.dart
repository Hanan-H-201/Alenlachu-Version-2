import 'package:app/controllers/common/authentication/authentication_cubit.dart';
import 'package:app/controllers/common/authentication/authentication_state.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/widgets/common/custome_form_components.dart';
import 'package:app/widgets/common/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InstitutionSignupForm extends StatefulWidget {
  const InstitutionSignupForm({super.key});

  @override
  State<InstitutionSignupForm> createState() => _InstitutionSignupFormState();
}

class _InstitutionSignupFormState extends State<InstitutionSignupForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _establishmentDateController =
      TextEditingController();
  final TextEditingController _languageController = TextEditingController();
  final TextEditingController _pricePerHourController = TextEditingController();

  String selectedCountryCode = '+251';
  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    _establishmentDateController.dispose();
    _languageController.dispose();
    _pricePerHourController.dispose();
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
                  _nameController,
                  Text(
                    'Insitution Name',
                    style: appTheme.textTheme.bodySmall,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Insitution Name';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: CustomFormComponents.buildNormalTextField(
                  _emailController,
                  Text(
                    'Email',
                    style: appTheme.textTheme.bodySmall,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
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
          CustomFormComponents.buildPasswordField(
            _confirmPasswordController,
            Text(
              'Confirm Password',
              style: appTheme.textTheme.bodyMedium,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }

              if (value != _passwordController.text.trim()) {
                return 'Passwords do not match';
              }

              return null;
            },
          ),
          const SizedBox(height: 15),
          CustomFormComponents.buildPhoneNumberField(
            _phoneNumberController,
            Text(
              'Phone',
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
                return 'Please enter your emergency contact number';
              }

              return null;
            },
          ),
          const SizedBox(height: 15),
          CustomFormComponents.buildDropdownInputField(
            Text(
              'Address',
              style: appTheme.textTheme.bodyMedium,
            ),
            ['Addis Ababa', 'Adama', 'Bahrdar', 'Dire Dawa'],
            'Addis Ababa',
            (String? newValue) {
              setState(() {
                _addressController.text = newValue ?? 'Addis Ababa';
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select your address';
              }

              return null;
            },
          ),
          const SizedBox(height: 15),
          CustomFormComponents.buildDatePickerField(
              context,
              _establishmentDateController,
              Text(
                'Establishment Date',
                style: appTheme.textTheme.bodyMedium,
              ), validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select establishment Date';
            }

            return null;
          }),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: CustomFormComponents.buildDropdownInputField(
                    Text(
                      'Language',
                      style: appTheme.textTheme.bodyMedium,
                    ),
                    ['English', 'Amharic'],
                    'English', (String? newValue) {
                  setState(() {
                    _languageController.text = newValue ?? 'English';
                  });
                }, validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select Language';
                  }

                  return null;
                }),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: CustomFormComponents.buildNormalTextField(
                    _pricePerHourController,
                    Text(
                      'Price',
                      style: appTheme.textTheme.bodyMedium,
                    ), validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter price';
                  }

                  return null;
                }),
              )
            ],
          ),
          const SizedBox(height: 15),
          BlocBuilder<AuthenticationCubit, AuthenticationState>(
            builder: (context, state) {
              return MainButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    context.read<AuthenticationCubit>().registerInstitution(
                        name: _nameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                        phoneNumber:
                            '$selectedCountryCode${_phoneNumberController.text}',
                        address: _addressController.text,
                        establishmentDate:
                            DateTime.parse(_establishmentDateController.text),
                        languageToProvideService: _languageController.text,
                        pricePerHour:
                            double.parse(_pricePerHourController.text));
                    // Form is valid, proceed with further processing
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(content: Text('Processing Data')),
                    // );
                  }
                },
                child: state is Authenticating
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text(
                        'Sign Up',
                        style: appTheme.textTheme.labelLarge,
                      ),
              );
            },
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account?',
                style: appTheme.textTheme.bodyMedium,
              ),
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/InstitutionLogin');
                },
                child: Text(
                  'Login',
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
