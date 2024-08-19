import 'dart:convert';

import 'package:app/controllers/common/authentication/authentication_state.dart';
import 'package:app/core/login_manager.dart';
import 'package:app/models/users/admin_model.dart';
import 'package:app/models/users/client/client_model.dart';
import 'package:app/models/users/institution_model.dart';
import 'package:app/models/users/profession_model.dart';
import 'package:app/services/common/authentication_service.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthenticationService authenticationService;

  AuthenticationCubit({
    required this.authenticationService,
  }) : super(AppInitial());

  Future<void> registerClient(
      {required String username,
      required String email,
      required String password,
      required String emergencyContact,
      String? fullName,
      String? phoneNumber,
      DateTime? dateOfBirth,
      String? nationality,
      String? residency,
      required bool isAnonymous}) async {
    emit(Authenticating());

    try {
      ClientModel client = ClientModel(
        username: username,
        email: email,
        password: password,
        emergencyContact: emergencyContact,
        fullName: fullName,
        phoneNumber: phoneNumber,
        dateOfBirth: dateOfBirth,
        nationality: nationality,
        residency: residency,
        isAnonymous: isAnonymous,
      );

      http.Response response =
          await authenticationService.registerClient(client);
      if (response.statusCode == 201) {
        print(
            "#################### response ${jsonDecode(response.body)}################");
        loginClient(username: client.username, password: client.password!);
      } else {
        final jsonRespones = jsonDecode(response.body);
        emit(UnauthenticatedClient(message: jsonRespones['error']));
      }
    } catch (e) {
      emit(AuthenticationFailed(errorMessage: e.toString()));
    }
  }

  Future<void> registreClientAnonymously(
      {required String username,
      required String email,
      required String password,
      required String emergencyContact,
      required bool isAnonymous}) async {
    emit(Authenticating());

    try {
      ClientModel client = ClientModel(
        username: username,
        email: email,
        password: password,
        emergencyContact: emergencyContact,
        isAnonymous: isAnonymous,
      );

      http.Response response =
          await authenticationService.registerClient(client);
      if (response.statusCode == 201) {
        loginClient(username: client.username, password: client.password!);
      } else {
        final jsonRespones = jsonDecode(response.body);
        emit(UnauthenticatedClient(message: jsonRespones['error']));
      }
    } catch (e) {
      emit(UnauthenticatedClient(message: e.toString()));
    }
  }

  Future<void> loginClient(
      {required String username, required String password}) async {
    emit(Authenticating());
    try {
      http.Response response =
          await authenticationService.loginClient(username, password);
      final jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        await LoginManager.saveUserToken(jsonResponse["token"]);
        await LoginManager.saveUserRole('client');
        Map<String, dynamic>? json = await authenticationService.getUser();
        emit(AuthenticatedAsClient(client: ClientModel.fromJson(json!)));
      } else {
        emit(UnauthenticatedClient(message: jsonResponse['error']));
      }
    } catch (e) {
      emit(UnauthenticatedClient(message: e.toString()));
    }
  }

  Future<void> loginAdmin(String email, String password) async {
    emit(Authenticating());
    try {
      http.Response response =
          await authenticationService.loginAdmin(email, password);
      final jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        await LoginManager.saveUserToken(jsonResponse["token"]);
        await LoginManager.saveUserRole('admin');
        Map<String, dynamic>? json = await authenticationService.getUser();
        emit(AuthenticatedAsAdmin(admin: AdminModel.fromJson(json!)));
      } else {
        emit(UnauthenticatedAdmin(message: jsonResponse['error']));
      }
    } catch (e) {
      emit(UnauthenticatedAdmin(message: e.toString()));
    }
  }

  Future<void> registerInstitution(
      {required String name,
      required String email,
      required String password,
      required String phoneNumber,
      required String address,
      required DateTime establishmentDate,
      required String languageToProvideService,
      required double pricePerHour}) async {
    emit(Authenticating());
    try {
      InstitutionModel institution = InstitutionModel(
          name: name,
          email: email,
          password: password,
          phoneNumber: phoneNumber,
          address: address,
          establishmentDate: establishmentDate,
          languageToProvideService: languageToProvideService,
          pricePerHour: pricePerHour);

      http.Response response =
          await authenticationService.registerInstitution(institution);
      if (response.statusCode == 201) {
        loginInstitution(
            email: institution.email, password: institution.password!);
      } else {
        final jsonRespone = jsonDecode(response.body);
        emit(UnauthenticatedInstitution(message: jsonRespone['error']));
      }
    } catch (e) {
      emit(UnauthenticatedInstitution(message: e.toString()));
    }
  }

  Future<void> loginInstitution(
      {required String email, required String password}) async {
    emit(Authenticating());
    try {
      http.Response response =
          await authenticationService.loginInstitution(email, password);
      final jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        await LoginManager.saveUserToken(jsonResponse["token"]);
        await LoginManager.saveUserRole('institution');
        Map<String, dynamic>? json = await authenticationService.getUser();
        InstitutionModel institution = InstitutionModel.fromJson(json!);
        emit(AuthenticatedAsInstitution(institution: institution));
      } else {
        emit(UnauthenticatedInstitution(message: jsonResponse['error']));
      }
    } catch (e) {
      emit(UnauthenticatedInstitution(message: e.toString()));
    }
  }

  Future<void> registerProfessional(
      {required String name,
      required String email,
      required String password,
      required String phoneNumber,
      required DateTime dateOfBirth,
      required String nationality,
      required String address,
      required String profession,
      required int experience,
      required String languageToProvideService,
      required double pricePerHour}) async {
    emit(Authenticating());
    try {
      ProfessionModel professionModel = ProfessionModel(
          name: name,
          email: email,
          password: password,
          phoneNumber: phoneNumber,
          dateOfBirth: dateOfBirth,
          nationality: nationality,
          address: address,
          profession: profession,
          experience: experience,
          languageToProvideService: languageToProvideService,
          pricePerHour: pricePerHour);

      http.Response respone =
          await authenticationService.registerProfessional(professionModel);
      if (respone.statusCode == 201) {
        loginProfessional(
            email: professionModel.email, password: professionModel.password!);
      } else {
        final jsonRespone = jsonDecode(respone.body);
        emit(UnauthenticatedProfessional(message: jsonRespone['error']));
      }
    } catch (e) {
      emit(UnauthenticatedProfessional(message: e.toString()));
    }
  }

  Future<void> loginProfessional(
      {required String email, required String password}) async {
    emit(Authenticating());
    try {
      http.Response response =
          await authenticationService.loginProfessional(email, password);
      final jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        await LoginManager.saveUserToken(jsonResponse["token"]);
        await LoginManager.saveUserRole('professional');
        Map<String, dynamic>? json = await authenticationService.getUser();
        ProfessionModel professional = ProfessionModel.fromJson(json!);
        emit(AuthenticatedAsProfessional(profession: professional));
      } else {
        emit(UnauthenticatedProfessional(message: jsonResponse['error']));
      }
    } catch (e) {
      emit(UnauthenticatedProfessional(message: e.toString()));
    }
  }

  void appStarted() {
    emit(AppStarted());
  }

  void authenticateClient(Map<String, dynamic> json) {
    emit(AuthenticatedAsClient(client: ClientModel.fromJson(json)));
  }

  void authenticateInstitution(Map<String, dynamic> json) {
    emit(AuthenticatedAsInstitution(
        institution: InstitutionModel.fromJson(json)));
  }

  void authenticateProfessional(Map<String, dynamic> json) {
    emit(AuthenticatedAsProfessional(
        profession: ProfessionModel.fromJson(json)));
  }

  void unAuthenticateClient(String message) {
    emit(UnauthenticatedClient(message: message));
  }

  void unAuthenticateInstitution(String message) {
    emit(UnauthenticatedInstitution(message: message));
  }

  void unAuthenticateProfessional(String message) {
    emit(UnauthenticatedProfessional(message: message));
  }

  void authenticationFaild(String error) {
    emit(AuthenticationFailed(errorMessage: error));
  }

  Future<void> logout() async {
    emit(Authenticating());
    try {
      await authenticationService.logout();

      await LoginManager.removeToken();
      await LoginManager.removeRole();

      emit(AppStarted());
    } catch (e) {
      emit(AuthenticationFailed(errorMessage: e.toString()));
    }
  }
}
