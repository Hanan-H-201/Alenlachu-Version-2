import 'package:app/models/common/event_model.dart';
import 'package:equatable/equatable.dart';

abstract class EventState extends Equatable {
  @override
  List<Object> get props => [];
}

final class EventInitial extends EventState {}

final class EventLoading extends EventState {}

final class EventSucceeded extends EventState {
  final String success;
  EventSucceeded({required this.success});

  @override
  List<Object> get props => [success];
}

final class EventError extends EventState {
  final String error;

  EventError({required this.error});

  @override
  List<Object> get props => [error];
}

final class EventLoaded extends EventState {
  final List<EventModel> events;

  EventLoaded({required this.events});

  @override
  List<Object> get props => [events];
}
