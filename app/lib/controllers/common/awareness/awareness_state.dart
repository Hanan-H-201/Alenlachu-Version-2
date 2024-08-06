import 'package:app/models/common/awareness_model.dart';
import 'package:equatable/equatable.dart';

abstract class AwarenessState extends Equatable {
  @override
  List<Object> get props => [];
}

final class AwarenessInitial extends AwarenessState {}

final class AwarenessLoading extends AwarenessState {}

final class AwarenessLoaded extends AwarenessState {
  final List<AwarenessModel> awarenesses;

  AwarenessLoaded({required this.awarenesses});

  @override
  List<Object> get props => [awarenesses];
}

final class AwarenessOperationError extends AwarenessState {
  final String error;

  AwarenessOperationError({required this.error});

  @override
  List<Object> get props => [error];
}

final class AwarenessOperationSuccess extends AwarenessState {
  final String success;

  AwarenessOperationSuccess({required this.success});

  @override
  List<Object> get props => [success];
}
