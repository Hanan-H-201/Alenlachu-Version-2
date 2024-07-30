import 'package:app/controllers/common/authentication/authentication_state.dart';
import 'package:app/models/users/client_model.dart';
import 'package:app/models/users/institution_model.dart';
import 'package:app/models/users/profession_model.dart';
import 'package:app/services/common/authentication_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthenticationService authenticationService;
  AuthenticationCubit({required this.authenticationService})
      : super(UnAuthenticated());

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

      ClientModel? registeredClient =
          await authenticationService.registerClient(client);
      emit(AuthenticatedAsClient(client: registeredClient!));
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

      ClientModel? registeredClient =
          await authenticationService.registerClient(client);
      emit(AuthenticatedAsClient(client: registeredClient!));
    } catch (e) {
      emit(AuthenticationFailed(errorMessage: e.toString()));
    }
  }

  Future<void> loginClient(
      {required String username, required String password}) async {
    emit(Authenticating());
    try {
      await authenticationService.loginClient(username, password);
      Map<String, dynamic>? json = await authenticationService.getUser();
      ClientModel client = ClientModel.fromJson(json!);
      emit(AuthenticatedAsClient(client: client));
    } catch (e) {
      emit(AuthenticationFailed(errorMessage: e.toString()));
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

      InstitutionModel? registeredInstitution =
          await authenticationService.registerInstitution(institution);
      emit(AuthenticatedAsInstitution(institution: registeredInstitution!));
    } catch (e) {
      emit(AuthenticationFailed(errorMessage: e.toString()));
    }
  }

  Future<void> loginInstitution(
      {required String email, required String password}) async {
    emit(Authenticating());
    try {
      await authenticationService.loginInstitution(email, password);
      Map<String, dynamic>? json = await authenticationService.getUser();
      InstitutionModel institution = InstitutionModel.fromJson(json!);
      emit(AuthenticatedAsInstitution(institution: institution));
    } catch (e) {
      emit(AuthenticationFailed(errorMessage: e.toString()));
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

      ProfessionModel? registeredProfessional =
          await authenticationService.registerProfessional(professionModel);
      emit(AuthenticatedAsProfessional(profession: registeredProfessional!));
    } catch (e) {
      emit(AuthenticationFailed(errorMessage: e.toString()));
    }
  }

  Future<void> loginProfessional(
      {required String email, required String password}) async {
    emit(Authenticating());
    try {
      await authenticationService.loginProfessional(email, password);
      Map<String, dynamic>? json = await authenticationService.getUser();
      ProfessionModel professional = ProfessionModel.fromJson(json!);
      emit(AuthenticatedAsProfessional(profession: professional));
    } catch (e) {
      emit(AuthenticationFailed(errorMessage: e.toString()));
    }
  }

  Future<void> logout() async {
    emit(Authenticating());
    try {
      await authenticationService.logout();
      emit(UnAuthenticated());
    } catch (e) {
      emit(AuthenticationFailed(errorMessage: e.toString()));
    }
  }
}
