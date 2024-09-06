// import 'package:app/controllers/common/phone_auth/phone_auth_cubit.dart';
// import 'package:app/controllers/common/phone_auth/phone_auth_state.dart';
// import 'package:app/core/theme/app_theme.dart';
// import 'package:app/screens/professionals_screens/professionl_landing_page.dart';
// import 'package:app/widgets/common/custome_form_components.dart';
// import 'package:app/widgets/common/main_button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';

// class VerifyOtp extends StatefulWidget {
//   const VerifyOtp({super.key});

//   @override
//   State<VerifyOtp> createState() => _VerifyOtpState();
// }

// class _VerifyOtpState extends State<VerifyOtp> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _codeController = TextEditingController();

//   @override
//   void dispose() {
//     _codeController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<PhoneAuthCubit, PhoneAuthState>(
//       listener: (context, state) {
//         if (state is PhoneAuthError) {
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//               content: Text(
//             state.errorMessage,
//             maxLines: 10,
//           )));
//         } else if (state is PhoneAuthVerified) {
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//               content: Text(
//             state.success,
//             maxLines: 10,
//           )));
//           Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => const ProfessionlLandingPage()),
//             (Route<dynamic> route) => false,
//           );
//         }
//       },
//       builder: (context, state) {
//         return Scaffold(
//           body: Form(
//             key: _formKey,
//             child: Center(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   state is PhoneAuthVerifyCode
//                       ? Text("OTP is Sent to ${state.phoneNumber}")
//                       : const Text("Processing..."),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   CustomFormComponents.buildNormalTextField(
//                     _codeController,
//                     const Text("Verify Code"),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'required'.tr;
//                       }

//                       if (value.length < 6 || value.length > 6) {
//                         return 'OTP must be 6 digit long';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   MainButton(
//                     onPressed: () {
//                       if (_formKey.currentState?.validate() ?? false) {
//                         if (state is PhoneAuthVerifyCode) {
//                           context.read<PhoneAuthCubit>().verifyOTP(
//                               state.verificationCode,
//                               _codeController.text.trim());
//                         } else {
//                           return;
//                         }
//                       }
//                     },
//                     child: state is PhoneAuthLoading
//                         ? const CircularProgressIndicator(
//                             color: Colors.white,
//                           )
//                         : Text(
//                             'verify'.tr,
//                             style: appTheme.textTheme.titleMedium,
//                           ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
