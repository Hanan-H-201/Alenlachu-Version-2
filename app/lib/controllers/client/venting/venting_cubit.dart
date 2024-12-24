import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:app/services/client/venting_service.dart';


part 'venting_state.dart';

class VentingCubit extends Cubit<VentingState> {
  final VentingService _ventingService;

  VentingCubit(this._ventingService) : super(VentingInitial());

  Future<void> fetchMessages() async {
    emit(VentingLoading());
    try {
      final messages = await _ventingService.fetchMessages();
      emit(VentingLoaded(messages));
    } catch (e) {
      emit(VentingError('Failed to load messages'));
    }
  }

  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;
    try {
      await _ventingService.sendMessage(text);
      fetchMessages(); // Refresh messages after sending
    } catch (e) {
      emit(VentingError('Failed to send message'));
    }
  }

  Future<void> editMessage(String id, String newText) async {
    try {
      await _ventingService.editMessage(id, newText);
      fetchMessages(); // Refresh messages after editing
    } catch (e) {
      emit(VentingError('Failed to edit message'));
    }
  }
}
