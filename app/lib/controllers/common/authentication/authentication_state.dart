import 'package:app/models/users/admin_model.dart';
import 'package:app/models/users/client_model.dart';
import 'package:app/models/users/institution_model.dart';
import 'package:app/models/users/profession_model.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AppInitial extends AuthenticationState {}

class AppStarted extends AuthenticationState {}

class UnauthenticatedClient extends AuthenticationState {
  final String message;
  UnauthenticatedClient({required this.message});

  @override
  List<Object> get props => [message];
}

class UnauthenticatedInstitution extends AuthenticationState {
  final String message;
  UnauthenticatedInstitution({required this.message});

  @override
  List<Object> get props => [message];
}

class UnauthenticatedProfessional extends AuthenticationState {
  final String message;
  UnauthenticatedProfessional({required this.message});

  @override
  List<Object> get props => [message];
}

class UnauthenticatedAdmin extends AuthenticationState {
  final String message;
  UnauthenticatedAdmin({required this.message});

  @override
  List<Object> get props => [message];
}

class Authenticating extends AuthenticationState {}

class AuthenticatedAsClient extends AuthenticationState {
  final ClientModel client;
  AuthenticatedAsClient({required this.client});

  @override
  List<Object> get props => [client];
}

class AuthenticatedAsInstitution extends AuthenticationState {
  final InstitutionModel institution;
  AuthenticatedAsInstitution({required this.institution});

  @override
  List<Object> get props => [institution];
}

class AuthenticatedAsProfessional extends AuthenticationState {
  final ProfessionModel profession;
  AuthenticatedAsProfessional({required this.profession});

  @override
  List<Object> get props => [profession];
}

class AuthenticatedAsAdmin extends AuthenticationState {
  final AdminModel admin;

  AuthenticatedAsAdmin({required this.admin});

  @override
  List<Object> get props => [admin];
}

class AuthenticationFailed extends AuthenticationState {
  final String errorMessage;
  AuthenticationFailed({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
