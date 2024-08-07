import 'package:app/widgets/client/journal/journal_bar.dart';
import 'package:app/widgets/client/journal/journal_list.dart';
import 'package:flutter/material.dart';

class JournalScreen extends StatelessWidget {
  const JournalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: const Stack(children: [
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 100),
            child: JournalList(),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: JournalBar(),
        ),
      ]),
    );
  }
}
