import 'dart:math';

import 'package:app/core/app.dart';
import 'package:app/core/login_manager.dart';
import 'package:app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final token = await LoginManager.getUserToken();
    final String? role = await LoginManager.getUserRole();
    runApp(MainApp(
      token: token,
      role: role,
    ));
  } catch (e) {
    log(double.parse(e.toString()));
  }
}
