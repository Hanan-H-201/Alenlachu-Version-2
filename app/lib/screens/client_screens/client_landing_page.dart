import 'package:app/controllers/client/bottom_nav/client_bottom_nav_cubit.dart';
import 'package:app/controllers/client/journal/journal_cubit.dart';
import 'package:app/controllers/common/awareness/awareness_cubit.dart';
import 'package:app/controllers/common/event/event_cubit.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/screens/client_screens/main/client_home_screen.dart';
import 'package:app/screens/client_screens/main/journal_screen.dart';
import 'package:app/screens/client_screens/main/profile_screen.dart';
import 'package:app/screens/client_screens/main/support_screen.dart';
import 'package:app/screens/client_screens/main/venting_screen.dart';
import 'package:app/widgets/client/journal/add_journal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ClientLandingPage extends StatefulWidget {
  const ClientLandingPage({super.key});

  @override
  State<ClientLandingPage> createState() => _ClientLandingPageState();
}

class _ClientLandingPageState extends State<ClientLandingPage> {
  @override
  void initState() {
    super.initState();
    context.read<EventCubit>().getEvents();
    context.read<AwarenessCubit>().getAllAwareness();
    context.read<JournalCubit>().getJournals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ClientBottomNavCubit, ClientBottomNavigationState>(
        builder: (context, state) {
          switch (state) {
            case ClientBottomNavigationState.home:
              return const ClientHomeScreen();
            case ClientBottomNavigationState.journal:
              return const JournalScreen();
            case ClientBottomNavigationState.venting:
              return const VentingScreen();
            case ClientBottomNavigationState.support:
              return const SupportScreen();
            case ClientBottomNavigationState.profile:
              return const ProfileScreen();
            default:
              return const ClientHomeScreen();
          }
        },
      ),
      floatingActionButton:
          BlocBuilder<ClientBottomNavCubit, ClientBottomNavigationState>(
        builder: (context, state) {
          switch (state) {
            case ClientBottomNavigationState.journal:
              return FloatingActionButton(
                backgroundColor: appTheme.primaryColor,
                elevation: 10,
                shape: const CircleBorder(),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: const AddJournalModal(),
                    ),
                  );
                },
                child: FaIcon(
                  FontAwesomeIcons.plus,
                  color: appTheme.scaffoldBackgroundColor,
                  size: 20,
                ),
              );
            default:
              return FloatingActionButton(
                backgroundColor: appTheme.primaryColor,
                elevation: 10,
                shape: const CircleBorder(),
                onPressed: null,
                child: FaIcon(
                  FontAwesomeIcons.robot,
                  color: appTheme.scaffoldBackgroundColor,
                  size: 20,
                ),
              );
          }
        },
      ),
      bottomNavigationBar:
          BlocBuilder<ClientBottomNavCubit, ClientBottomNavigationState>(
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: ClientBottomNavigationState.values.indexOf(state),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: appTheme.primaryColor,
            unselectedItemColor: Colors.grey,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.house,
                  size: 20,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.penToSquare, size: 20),
                label: 'Journal',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.handHoldingHand, size: 20),
                label: 'Venting',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.users, size: 20),
                label: 'Support',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.user, size: 20),
                label: 'Profile',
              ),
            ],
            onTap: (index) {
              context
                  .read<ClientBottomNavCubit>()
                  .selectItem(ClientBottomNavigationState.values[index]);
            },
          );
        },
      ),
    );
  }
}
