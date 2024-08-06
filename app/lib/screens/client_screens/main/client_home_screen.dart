import 'package:app/controllers/common/awareness/awareness_cubit.dart';
import 'package:app/controllers/common/event/event_cubit.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/widgets/client/home/client_emotional_state.dart';
import 'package:app/widgets/client/home/event/event_list.dart';
import 'package:app/widgets/client/home/motivational_qoutes.dart';
import 'package:app/widgets/client/home/welcome_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../widgets/client/home/awareness/awareness_list.dart';

class ClientHomeScreen extends StatelessWidget {
  const ClientHomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Future<void> updateData() async {
      context.read<EventCubit>().getEvents();
      context.read<AwarenessCubit>().getAllAwareness();
    }

    return RefreshIndicator(
      onRefresh: () {
        return updateData();
      },
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                    height:
                        110), // Adjust this height according to the height of WelcomeCard
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('How are You Feeling Today?',
                          style: appTheme.textTheme.labelLarge),
                      const SizedBox(height: 10),
                      const ClientEmotionalState(),
                      const SizedBox(height: 10),
                      MotivationalQuotesCarousel(),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.compass,
                            color: appTheme.primaryColor,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Text('Explore events',
                              style: appTheme.textTheme.labelLarge),
                          const Spacer(),
                          Text('See All', style: appTheme.textTheme.labelSmall),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const EventList(),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.lightbulb,
                            color: appTheme.primaryColor,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Text('Articles',
                              style: appTheme.textTheme.labelLarge),
                          const Spacer(),
                          Text('See All', style: appTheme.textTheme.labelSmall),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const AwarenessList(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: WelcomeCard(),
          ),
        ],
      ),
    );
  }
}
