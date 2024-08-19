import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class LanguageManager {
  static const String _langKey = 'language';

  static Future<void> setPreferredLanguage(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_langKey, locale.toLanguageTag());
    Get.updateLocale(locale);
  }

  static Future<Locale?> getPreferredLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final languageTag = prefs.getString(_langKey);
    if (languageTag != null) {
      return Locale.fromSubtags(languageCode: languageTag);
    }
    return null;
  }

  // Update the language and notify listeners (if any)
  static Future<void> updateLanguage(Locale locale) async {
    await setPreferredLanguage(locale);
    await Get.updateLocale(locale);
  }
}
