// import 'dart:developer' as developer;
// import 'dart:math';

// import 'package:app/controllers/common/phone_auth/phone_auth_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:twilio_flutter/twilio_flutter.dart';

// class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  

//   PhoneAuthCubit() : super(PhoneAuthInitial());

//   void sendSMS(String phoneNumber) async {
//     twilioFlutter = TwilioFlutter(
//         accountSid: accountSID,
//         authToken: authToken,
//         twilioNumber: tiwiloNumber);

//     var rnd = Random();

//     var digits = rnd.nextInt(900000) + 100000;
//     developer.log(digits.toString());

//     emit(PhoneAuthLoading());
//     try {
//       final result = await twilioFlutter.sendSMS(
//           toNumber: phoneNumber,
//           messageBody:
//               'Hello This is 6 digit otp code to verify phone $digits');
//       developer.log(result.toString());
//       if (result.responseCode != 200) {
//         emit(PhoneAuthError(
//             errorMessage: 'Failed to send SMS: ${result.toString()}'));
//       } else {
//         emit(PhoneAuthVerifyCode(
//             verificationCode: digits.toString(), phoneNumber: phoneNumber));
//       }
//     } catch (e) {
//       emit(PhoneAuthError(errorMessage: e.toString()));
//     }
//   }

//   void verifyOTP(String sentCode, String userCode) {
//     emit(PhoneAuthLoading());
//     if (sentCode == userCode) {
//       emit(PhoneAuthVerified(success: 'Successfully Verfied'));
//     } else {
//       emit(PhoneAuthError(errorMessage: 'Authentication Faild'));
//     }
//   }
// }
