import 'package:app/models/common/awareness_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_theme.dart';

class AwarenessCard extends StatelessWidget {
  final AwarenessModel awareness;
  const AwarenessCard({super.key, required this.awareness});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: BoxDecoration(
            color: appTheme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 234, 234, 234),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 3),
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 130,
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  image: DecorationImage(
                      image: awareness.image == null
                          ? const AssetImage(
                              'assets/images/awarness_default.png')
                          : NetworkImage(awareness.image!),
                      fit: BoxFit.fill)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(awareness.title,
                      maxLines: 1, style: appTheme.textTheme.labelMedium),
                  const SizedBox(height: 10),
                  Text(awareness.content,
                      maxLines: 3, style: appTheme.textTheme.bodyMedium),
                  const SizedBox(height: 5),
                  Center(
                      child: Text(
                    'read more'.tr,
                    style: appTheme.textTheme.labelSmall,
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
