import 'package:app/models/users/client_model.dart';
import 'package:app/models/users/institution_model.dart';
import 'package:app/models/users/profession_model.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class UnAuthenticated extends AuthenticationState {}

class Authenticating extends AuthenticationState {}

class AuthenticatedAsClient extends AuthenticationState {
  final ClientModel client;
  AuthenticatedAsClient({required this.client});
}

class AuthenticatedAsInstitution extends AuthenticationState {
  final InstitutionModel institution;
  AuthenticatedAsInstitution({required this.institution});
}

class AuthenticatedAsProfessional extends AuthenticationState {
  final ProfessionModel profession;
  AuthenticatedAsProfessional({required this.profession});
}

class AuthenticationFailed extends AuthenticationState {
  final String errorMessage;
  AuthenticationFailed({required this.errorMessage});
}
