import 'dart:convert';

import 'package:app/core/api.dart';
import 'package:app/core/login_manager.dart';
import 'package:app/models/users/client_model.dart';
import 'package:app/models/users/institution_model.dart';
import 'package:app/models/users/profession_model.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthenticationService {
  Future<ClientModel?> registerClient(ClientModel client) async {
    try {
      final response = await http.post(
        Uri.parse(ApiUrl.clientRegistrationUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(client.toJson()),
      );

      if (response.statusCode == 201) {
        await loginClient(client.username, client.password);

        Map<String, dynamic>? json = await getUser();
        return ClientModel.fromJson(json!);
      }
    } catch (e) {
      throw Exception('Failed to register client: $e');
    }
    return null;
  }

  Future<void> loginClient(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse(ApiUrl.clientLoginUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        await LoginManager.saveUserToken(jsonResponse["token"]);
      } else {
        throw Exception(
            'Operation Faild: Server returned  ${jsonDecode(response.body)}');
      }
    } catch (e) {
      throw Exception('Failed to login client: $e');
    }
  }

  Future<ProfessionModel?> registerProfessional(
      ProfessionModel professional) async {
    try {
      final respone =
          await http.post(Uri.parse(ApiUrl.professionalsRegistrationUrl),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(professional.toJson()));

      if (respone.statusCode == 201) {
        await loginProfessional(professional.email, professional.password);

        Map<String, dynamic>? json = await getUser();
        return ProfessionModel.fromJson(json!);
      }
    } catch (e) {
      throw Exception('Failed to register professional: $e');
    }
    return null;
  }

  Future<void> loginProfessional(String email, String password) async {
    try {
      final response = await http.post(Uri.parse(ApiUrl.professionalLoginUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({'email': email, 'password': password}));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        await LoginManager.saveUserToken(jsonResponse["token"]);
      } else {
        throw Exception(
            'Operation Faild: Server returned  ${jsonDecode(response.body)}');
      }
    } catch (e) {
      throw Exception('Failed to login professional: $e');
    }
  }

  Future<InstitutionModel?> registerInstitution(
      InstitutionModel institution) async {
    try {
      final response = await http.post(
        Uri.parse(ApiUrl.institutionRegistrationUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(institution.toJson()),
      );

      if (response.statusCode == 201) {
        await loginInstitution(institution.email, institution.password);

        Map<String, dynamic>? json = await getUser();
        return InstitutionModel.fromJson(json!);
      }
    } catch (e) {
      throw Exception('Failed to register institution: $e');
    }
    return null;
  }

  Future<void> loginInstitution(String email, String password) async {
    try {
      final response = await http.post(Uri.parse(ApiUrl.institutionLoginUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({'email': email, 'password': password}));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        await LoginManager.saveUserToken(jsonResponse["token"]);
      } else {
        throw Exception(
            'Operation Faild: Server returned  ${jsonDecode(response.body)}');
      }
    } catch (e) {
      throw Exception('Failed to login institution: $e');
    }
  }

  Future<Map<String, dynamic>?> getUser() async {
    try {
      final token = await LoginManager.getUserToken();
      Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(token!);
      return jwtDecodedToken;
    } catch (e) {
      throw Exception('Failed to get user: $e');
    }
  }

  Future<void> logout() async {
    try {
      final token = await LoginManager.getUserToken();
      final response = await http.post(
        Uri.parse(ApiUrl.logoutUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        await LoginManager.removeToken();
      } else {
        throw Exception(
            'Failed to logout: Server returned  ${jsonDecode(response.body)}');
      }
    } catch (e) {
      throw Exception('Failed to logout: $e');
    }
  }
}
