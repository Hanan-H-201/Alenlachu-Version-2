import 'package:app/controllers/common/authentication/authentication_state.dart';
import 'package:app/models/users/client_model.dart';
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

  Future<void> registerInstitution() async {}

  Future<void> registerProfessional() async {}

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
