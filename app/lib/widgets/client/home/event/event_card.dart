import 'package:app/core/theme/app_theme.dart';
import 'package:app/models/common/event_model.dart';
import 'package:app/services/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EventCard extends StatelessWidget {
  final EventModel event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => EventDetailPage(event: event)));
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.43,
        width: MediaQuery.of(context).size.width * 0.7,
        decoration: BoxDecoration(
            color: appTheme.scaffoldBackgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 234, 234, 234),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 3),
              )
            ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 130,
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: event.image == null
                          ? const AssetImage(
                              'assets/images/event_default.png')
                          : NetworkImage(event.image!),
                      fit: BoxFit.fill)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    event.title,
                    maxLines: 1,
                    style: appTheme.textTheme.labelMedium
                  ),
                  const SizedBox(height: 5),
                  Text(
                      event.description,
                      maxLines: 3,
                      style: appTheme.textTheme.bodyMedium
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const FaIcon(FontAwesomeIcons.clock, size: 12,),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        Utils.formatDate(event.date),
                        style: appTheme.textTheme.bodySmall,
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  GestureDetector(
                      onTap: () async {
                        try {
                          await event.openMaps();
                        } catch (e) {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())));
                        }
                      },
                      child: Row(
                        children: [
                          FaIcon(FontAwesomeIcons.locationDot, size: 15,color: appTheme.primaryColor,),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text(
                              event.location,
                              maxLines: 1,
                              style: appTheme.textTheme.labelSmall,
                            ),
                          )
                        ],
                      )),
                  const SizedBox(height: 5),
                  Center(child: Text('View Detail', style: appTheme.textTheme.labelSmall,))

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
