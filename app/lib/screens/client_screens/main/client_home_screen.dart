import 'package:app/core/theme/app_theme.dart';
import 'package:app/widgets/client/home/client_emotional_state.dart';
import 'package:app/widgets/client/home/motivational_qoutes.dart';
import 'package:app/widgets/client/home/welcome_card.dart';
import 'package:flutter/material.dart';

class ClientHomeScreen extends StatelessWidget {
  const ClientHomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const WelcomeCard(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('How are You Feeling Today?',
                  style: appTheme.textTheme.headlineSmall),
              const SizedBox(
                height: 10,
              ),
              const ClientEmotionalState(),
              const SizedBox(
                height: 10,
              ),
              MotivationalQuotesCarousel(),
              const SizedBox(
                height: 10,
              ),
              Text('Explore events', style: appTheme.textTheme.headlineSmall),
            ],
          ),
        ),
      ],
    ));
  }
}
