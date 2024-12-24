part of 'venting_cubit.dart';

abstract class VentingState extends Equatable {
  @override
  List<Object> get props => [];
}

class VentingInitial extends VentingState {}

class VentingLoading extends VentingState {}

class VentingLoaded extends VentingState {
  final List<Map<String, dynamic>> messages;

  VentingLoaded(this.messages);

  @override
  List<Object> get props => [messages];
}

class VentingError extends VentingState {
  final String message;

  VentingError(this.message);

  @override
  List<Object> get props => [message];
}
