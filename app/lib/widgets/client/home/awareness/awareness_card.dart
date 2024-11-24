import 'package:app/models/common/awareness_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_theme.dart';

class AwarenessCard extends StatelessWidget {
  final AwarenessModel awareness;
  const AwarenessCard({super.key, required this.awareness});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the detail view of the awareness article
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            // Left Image
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: awareness.image == null
                      ? const AssetImage('assets/images/awarness_default.png')
                      : NetworkImage(awareness.image!) as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            // Right Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    awareness.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.dmSans(
                      textStyle: appTheme.textTheme.labelMedium,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Content (Description)
                  Text(
                    awareness.content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.dmSans(
                      textStyle: appTheme.textTheme.bodyMedium,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Read More Link
                  GestureDetector(
                    onTap: () {
                      // Navigate to full article details
                    },
                    child: Text(
                      'read more'.tr,
                      style: GoogleFonts.dmSans(
                        textStyle: appTheme.textTheme.labelSmall,
                        color: appTheme.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
