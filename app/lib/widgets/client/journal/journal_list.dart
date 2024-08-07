import 'package:app/controllers/client/journal/journal_cubit.dart';
import 'package:app/controllers/client/journal/journal_state.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/models/users/client/journal_model.dart';
import 'package:app/widgets/client/journal/journal_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JournalList extends StatefulWidget {
  const JournalList({super.key});

  @override
  State<JournalList> createState() => _JournalListState();
}

class _JournalListState extends State<JournalList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JournalCubit, JournalState>(
      builder: (context, state) {
        if (state is JournalLoaded) {
          if (state.journals.isEmpty) {
            return Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/empty.png',
                    height: 200,
                  ),
                  Text(
                    'Save your Days',
                    style: appTheme.textTheme.bodySmall,
                  )
                ],
              ),
            );
          } else {
            return Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.only(bottom: 200),
              child: ListView.builder(
                itemCount: state.journals.length,
                itemBuilder: (context, index) {
                  final JournalModel journal = state.journals[index];
                  return Column(
                    children: [
                      JournalCard(journal: journal),
                      const SizedBox(
                        height: 15,
                      )
                    ],
                  );
                },
              ),
            );
          }
        } else if (state is JournalLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: appTheme.primaryColor,
            ),
          );
        } else if (state is JournalOperationError) {
          return Center(
            child: Text(
              'Error loading journal: ${state.message}',
              style: appTheme.textTheme.bodySmall,
            ),
          );
        } else {
          return const Center(
            child: Text('Unknown error Occured'),
          );
        }
      },
    );
  }
}
