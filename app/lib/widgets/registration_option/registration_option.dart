import 'package:app/core/theme/app_theme.dart';
import 'package:app/widgets/common/anonymous_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationOptionCard extends StatelessWidget {
  const RegistrationOptionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          buildOption(context, 'client'.tr, () async {
            final bool? result =
                await AnonymousRequest.showAnonymousUsageDialog(context);
            if (result == true) {
              // ignore: use_build_context_synchronously
              Navigator.pushNamed(context, '/clientAnonymousRegistration');
            } else if (result == false) {
              // ignore: use_build_context_synchronously
              Navigator.pushNamed(context, '/clientRegistration');
            } else {
              return;
            }
          }),
          const SizedBox(
            height: 10,
          ),
          buildOption(context, 'professional'.tr, () {
            Navigator.pushNamed(context, '/professionalRegistration');
          }),
          const SizedBox(
            height: 10,
          ),
          buildOption(context, 'institution'.tr, () {
            Navigator.pushNamed(context, '/institutionRegistration');
          }),
          const SizedBox(
            height: 10,
          ),
          buildOption(context, 'admin'.tr, () {
            Navigator.pushNamed(context, '/adminLogin');
          }),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget buildOption(
      BuildContext context, String lable, void Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: appTheme.primaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Center(
          child: Text(
            lable,
            style: appTheme.textTheme.titleMedium,
          ),
        ),
      ),
    );
  }
}
