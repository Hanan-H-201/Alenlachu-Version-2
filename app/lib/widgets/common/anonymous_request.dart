import 'package:app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnonymousRequest {
  static Future<bool?> showAnonymousUsageDialog(BuildContext context) async {
    bool? result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('anon'.tr),
          content: Text(
            'anon request'.tr,
            maxLines: 10,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('no'.tr, style: appTheme.textTheme.labelMedium),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(
                'yes'.tr,
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
            title: Text('thank'.tr),
            content: Text('anon true'.tr, maxLines: 10),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('ok'.tr, style: appTheme.textTheme.labelMedium),
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
            title: Text('thank'.tr),
            content: Text('anon false'.tr, maxLines: 10),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('ok'.tr, style: appTheme.textTheme.labelMedium),
              ),
            ],
          );
        },
      );
    }
    return result;
  }
}
