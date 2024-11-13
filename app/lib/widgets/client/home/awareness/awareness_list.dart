import 'package:app/controllers/common/awareness/awareness_cubit.dart';
import 'package:app/models/common/awareness_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../controllers/common/awareness/awareness_state.dart';
import '../../../../core/theme/app_theme.dart';
import 'awareness_card.dart';

class AwarenessList extends StatefulWidget {
  const AwarenessList({super.key});

  @override
  State<AwarenessList> createState() => _AwarenessListState();
}

class _AwarenessListState extends State<AwarenessList> {
  final int previewLimit = 2; // Number of items to preview

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AwarenessCubit, AwarenessState>(
      builder: (context, state) {
        if (state is AwarenessLoaded) {
          if (state.awarenesses.isEmpty) {
            return Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/empty.png',
                    height: 200,
                  ),
                  Text(
                    'noarticles'.tr,
                    style: appTheme.textTheme.bodySmall,
                  )
                ],
              ),
            );
          } else {
            // Display a limited list with a "View All" link after previewLimit items
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Preview List
                ...List.generate(
                  state.awarenesses.length > previewLimit
                      ? previewLimit
                      : state.awarenesses.length,
                      (index) {
                    final AwarenessModel awareness = state.awarenesses[index];
                    return AwarenessCard(awareness: awareness);
                  },
                ),
              ],
            );
          }
        } else if (state is AwarenessLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: appTheme.primaryColor,
            ),
          );
        } else if (state is AwarenessOperationError) {
          return Center(
            child: Text(state.error),
          );
        } else {
          return const Center(
            child: Text('Unknown error occurred'),
          );
        }
      },
    );
  }
}
