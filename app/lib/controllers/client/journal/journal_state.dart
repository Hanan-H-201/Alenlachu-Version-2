import 'package:app/models/users/client/journal_model.dart';
import 'package:equatable/equatable.dart';

abstract class JournalState extends Equatable {
  @override
  List<Object> get props => [];
}

final class JournalInitial extends JournalState {}

final class JournalLoading extends JournalState {}

final class JournalOperationError extends JournalState {
  final String message;

  JournalOperationError({required this.message});
  @override
  List<Object> get props => [message];
}

final class JournalOperationSuccess extends JournalState {
  final String message;

  JournalOperationSuccess({required this.message});
  @override
  List<Object> get props => [message];
}

final class JournalLoaded extends JournalState {
  final List<JournalModel> journals;

  JournalLoaded({required this.journals});

  @override
  List<Object> get props => [journals];
}
