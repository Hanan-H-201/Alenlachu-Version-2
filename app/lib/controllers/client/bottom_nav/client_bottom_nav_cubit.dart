import 'package:flutter_bloc/flutter_bloc.dart';

enum ClientBottomNavigationState { home, journal, venting, support, profile }

class ClientBottomNavCubit extends Cubit<ClientBottomNavigationState> {
  ClientBottomNavCubit() : super(ClientBottomNavigationState.home);

  void selectItem(ClientBottomNavigationState item) {
    emit(item);
  }
}
