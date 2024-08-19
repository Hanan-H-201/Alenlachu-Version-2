import 'package:app/core/theme/app_theme.dart';
import 'package:app/services/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SettingCard extends StatelessWidget {
  const SettingCard({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> settings = [
      {
        'name': 'profile'.tr,
        'icon': const FaIcon(FontAwesomeIcons.user, size: 20),
        'onTap': () {}
      },
      {
        'name': 'language'.tr,
        'icon': const FaIcon(FontAwesomeIcons.language, size: 20),
        'onTap': () => Utils.changeLanguage(context)
      },
      {
        'name': 'about'.tr,
        'icon': const FaIcon(FontAwesomeIcons.info, size: 20),
        'onTap': () {}
      }
    ];
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: ListView.builder(
        itemCount: settings.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> settinCardDetail = settings[index];
          return Column(
            children: [
              settingCardInfo(settinCardDetail, context),
              const SizedBox(height: 10),
            ],
          );
        },
      ),
    );
  }
}

Widget settingCardInfo(Map<String, dynamic> json, BuildContext context) {
  return GestureDetector(
    onTap: json['onTap'],
    child: Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: appTheme.scaffoldBackgroundColor,
        boxShadow: const [
          BoxShadow(
              blurRadius: 4,
              color: Color.fromARGB(255, 230, 230, 230),
              offset: Offset(0, 2),
              spreadRadius: 2)
        ],
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: appTheme.primaryColor.withOpacity(0.2),
          child: json['icon'],
        ),
        title: Text(
          json['name'],
          style: appTheme.textTheme.labelMedium,
        ),
        trailing: FaIcon(
          FontAwesomeIcons.angleRight,
          color: appTheme.primaryColor,
          size: 18,
        ),
        onTap: json['onTap'],
      ),
    ),
  );
}
