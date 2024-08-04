import 'package:app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AnonymousRequest {
  static Future<bool?> showAnonymousUsageDialog(BuildContext context) async {
    bool? result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Continue Anonymously?'),
          content: const Text(
              'Would you like to continue using the app anonymously?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('No', style: appTheme.textTheme.labelMedium),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(
                'Yes',
                style: appTheme.textTheme.labelMedium,
              ),
            ),
          ],
        );
      },
    );

    if (result == true) {
      await showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Thank You'),
            content: const Text(
                'You have chosen to continue anonymously. Rest assured, your sensitive information will not be disclosed.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK', style: appTheme.textTheme.labelMedium),
              ),
            ],
          );
        },
      );
    } else if (result == false) {
      await showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Thank you'),
            content: const Text(
                'You can still choose to remain anonymous for using other sensitive features of the app'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK', style: appTheme.textTheme.labelMedium),
              ),
            ],
          );
        },
      );
    }
    return result;
  }
}
