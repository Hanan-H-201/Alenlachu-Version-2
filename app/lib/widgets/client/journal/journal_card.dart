import 'package:app/controllers/client/journal/journal_cubit.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/models/users/client/journal_model.dart';
import 'package:app/services/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class JournalCard extends StatefulWidget {
  final JournalModel journal;
  const JournalCard({super.key, required this.journal});

  @override
  State<JournalCard> createState() => _JournalCardState();
}

class _JournalCardState extends State<JournalCard> {
  void _pickColor() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pick a color'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: widget.journal.getColor(),
            onColorChanged: (color) {
              widget.journal.color = Utils.getColorInHex(color);
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              context
                  .read<JournalCubit>()
                  .updateJournal(updatedJournal: widget.journal);
              Navigator.of(context).pop();
            },
            child: const Text('Select'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              color: widget.journal.getColor().withOpacity(0.6),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(255, 186, 186, 186),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 3),
                )
              ],
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: _pickColor,
                    child: CircleAvatar(
                      backgroundColor: appTheme.scaffoldBackgroundColor,
                      radius: 20,
                      child: CircleAvatar(
                        backgroundColor: widget.journal.getColor(),
                        radius: 10,
                      ),
                    ),
                  ),
                  Text(
                    Utils.getDay(widget.journal.date),
                    style: appTheme.textTheme.titleMedium,
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.journal.toggleFavorite();
                      context
                          .read<JournalCubit>()
                          .updateJournal(updatedJournal: widget.journal);
                    },
                    child: CircleAvatar(
                      backgroundColor:
                          appTheme.scaffoldBackgroundColor.withOpacity(0.5),
                      child: widget.journal.isFavorite
                          ? const FaIcon(
                              FontAwesomeIcons.solidHeart,
                              color: Colors.red,
                            )
                          : FaIcon(
                              FontAwesomeIcons.heart,
                              color: appTheme.scaffoldBackgroundColor,
                            ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          flex: 4,
          child: Container(
            height: 200,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                color: widget.journal.getColor().withOpacity(0.3),
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: const []),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(Utils.formatDate(widget.journal.date),
                    style: appTheme.textTheme.labelMedium),
                const Divider(
                  color: Colors.grey,
                  thickness: 3,
                ),
                Text(
                  widget.journal.content,
                  style: appTheme.textTheme.bodySmall,
                  maxLines: 7,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
