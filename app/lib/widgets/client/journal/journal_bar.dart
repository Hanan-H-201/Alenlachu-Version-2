import 'package:app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class JournalBar extends StatelessWidget {
  const JournalBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 40, bottom: 10),
      decoration: BoxDecoration(
          color: appTheme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 234, 234, 234),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 1),
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: appTheme.scaffoldBackgroundColor.withOpacity(1),
            radius: 30,
            child: Image.asset('assets/images/logo.png'),
          ),
          Text(
            'My Diary',
            style: appTheme.textTheme.labelMedium,
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
