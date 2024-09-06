import 'dart:developer' as developer;
import 'dart:math';

import 'package:app/controllers/common/phone_auth/phone_auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  final String accountSID = 'ACb39f6a7fa5374317c08c0c2fec1afd3b';
  final String authToken = '31250462d5673bd5c041f4d388b0f6bb';
  final String tiwiloNumber = '+251900624702';
  late TwilioFlutter twilioFlutter;

  PhoneAuthCubit() : super(PhoneAuthInitial());

  void sendSMS(String phoneNumber) async {
    twilioFlutter = TwilioFlutter(
        accountSid: accountSID,
        authToken: authToken,
        twilioNumber: tiwiloNumber);

    var rnd = Random();

    var digits = rnd.nextInt(900000) + 100000;
    developer.log(digits.toString());

    emit(PhoneAuthLoading());
    try {
      final result = await twilioFlutter.sendSMS(
          toNumber: phoneNumber,
          messageBody:
              'Hello This is 6 digit otp code to verify phone $digits');
      developer.log(result.toString());
      if (result.responseCode != 200) {
        emit(PhoneAuthError(
            errorMessage: 'Failed to send SMS: ${result.toString()}'));
      } else {
        emit(PhoneAuthVerifyCode(
            verificationCode: digits.toString(), phoneNumber: phoneNumber));
      }
    } catch (e) {
      emit(PhoneAuthError(errorMessage: e.toString()));
    }
  }

  void verifyOTP(String sentCode, String userCode) {
    emit(PhoneAuthLoading());
    if (sentCode == userCode) {
      emit(PhoneAuthVerified(success: 'Successfully Verfied'));
    } else {
      emit(PhoneAuthError(errorMessage: 'Authentication Faild'));
    }
  }
}
