import 'package:app/core/language/language_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Utils {
  static String getGreeting() {
    final now = DateTime.now();
    final hour = now.hour;

    if (hour >= 0 && hour < 12) {
      return 'good morning'.tr;
    } else if (hour >= 12 && hour < 17) {
      return 'good afternoon'.tr;
    } else {
      return 'good evening'.tr;
    }
  }

  static String formatDate(DateTime date) {
    return DateFormat('MMMM d,yyyy').format(date);
  }

  static String getDay(DateTime date) {
    return DateFormat('EEE').format(date);
  }

  static String getColorInHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').substring(2)}';
  }

  static void changeLanguage(BuildContext context) {
    final List locale = [
      {'name': 'English', 'locale': const Locale('en')},
      {'name': 'አማርኛ', 'locale': const Locale('am')}
    ];
    showDialog(
      context: context,
      builder: (builder) {
        return AlertDialog(
          title: Text('language'.tr),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: locale.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(locale[index]['name']),
                  onTap: () async {
                    try {
                      var selectedLocale = locale[index]['locale'];

                      await LanguageManager.setPreferredLanguage(
                          selectedLocale);

                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop();
                    } catch (e) {
                      debugPrint(e.toString());
                    }
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  color: Colors.grey,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
