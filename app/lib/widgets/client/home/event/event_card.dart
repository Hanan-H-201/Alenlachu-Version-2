import 'package:app/core/theme/app_theme.dart';
import 'package:app/models/common/event_model.dart';
import 'package:app/services/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width * 0.7,
        decoration: BoxDecoration(
            color: appTheme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 234, 234, 234),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 3),
              )
            ]),
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      image: event.image == null
                          ? const AssetImage('assets/images/event_default.png')
                          : NetworkImage(event.image!) as ImageProvider,
                      fit: BoxFit.fitHeight)),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.2)
                  ],
                  begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                )
              ),
            ),
              Positioned(
                bottom: 15,
                left: 15,
                right: 15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.dmSans(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                    const SizedBox(height: 5,),
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
                                    FaIcon(
                                      FontAwesomeIcons.locationDot,
                                      size: 15,
                                      color: appTheme.primaryColor,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Text(
                                        event.location,
                                        maxLines: 1,
                                        style: GoogleFonts.dmSans(
                                            fontSize: 13,
                                            color: Colors.white,)
                                      ),
                                    )
                                  ],
                                )),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.calendar,
                                  size: 12,
                                  color: appTheme.primaryColor,
                                ),
                                const SizedBox(width: 5,),
                                Text(
                                  Utils.formatDate(event.date),
                                  style: GoogleFonts.dmSans(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),

                            const SizedBox(width: 90),
                            Text('View more'.tr,
                              style: GoogleFonts.dmSans(
                                  textStyle:appTheme.textTheme.labelSmall,
                                  color: appTheme.primaryColor,
                                fontSize: 13
                              ),
                            ),
                          ],
                        )


                  ],
                ),
              )
  ]
        ),
      ),
    );
  }
}
