import 'package:app/controllers/common/event/event_cubit.dart';
import 'package:app/controllers/common/event/event_state.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/models/common/event_model.dart';
import 'package:app/widgets/client/home/event/event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class EventList extends StatefulWidget {
  const EventList({super.key});

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.45,
      child: BlocBuilder<EventCubit, EventState>(
        builder: (context, state) {
          if (state is EventLoaded) {
            if (state.events.isEmpty) {
              return Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/empty.png',
                      height: 200,
                    ),
                    Text(
                      'noevent'.tr,
                      style: appTheme.textTheme.bodySmall,
                    )
                  ],
                ),
              );
            } else {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.events.length,
                itemBuilder: (context, index) {
                  final EventModel event = state.events[index];
                  return Row(
                    children: [
                      EventCard(event: event),
                      const SizedBox(
                        width: 20,
                      )
                    ],
                  );
                },
              );
            }
          } else if (state is EventLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: appTheme.primaryColor,
              ),
            );
          } else if (state is EventError) {
            return Center(
              child: Text(state.error),
            );
          } else {
            return const Center(
              child: Text('Unknown error occured'),
            );
          }
        },
      ),
    );
  }
}
