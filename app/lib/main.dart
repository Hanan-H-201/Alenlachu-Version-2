import 'dart:math';

import 'package:app/controllers/common/authentication/authentication_cubit.dart';
import 'package:app/core/app.dart';
import 'package:app/firebase_options.dart';
import 'package:app/services/common/authentication_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    runApp(BlocProvider(
      create: (context) => AuthenticationCubit(
        authenticationService: AuthenticationService(),
      ),
      child: const MainApp(),
    ));
  } catch (e) {
    log(double.parse(e.toString()));
  }
}
