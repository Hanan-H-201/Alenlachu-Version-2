import 'dart:convert';

import 'package:app/core/api.dart';
import 'package:app/core/login_manager.dart';
import 'package:app/models/users/client/client_model.dart';
import 'package:app/models/users/institution_model.dart';
import 'package:app/models/users/profession_model.dart';

import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthenticationService {
  Future<http.Response> registerClient(ClientModel client) async {
    final response = await http.post(
      Uri.parse(ApiUrl.clientRegistrationUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(client.toJson()),
    );

    return response;
  }

  Future<http.Response> loginClient(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse(ApiUrl.clientLoginUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'username': username, 'password': password}),
      );

      return response;
    } catch (e) {
      throw Exception('Failed to login client: $e');
    }
  }

  Future<http.Response> registerProfessional(
      ProfessionModel professional) async {
    try {
      final respone =
          await http.post(Uri.parse(ApiUrl.professionalsRegistrationUrl),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(professional.toJson()));

      return respone;
    } catch (e) {
      throw Exception('Failed to register professional: $e');
    }
  }

  Future<http.Response> loginProfessional(String phone, String password) async {
    try {
      final response = await http.post(Uri.parse(ApiUrl.professionalLoginUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({'phoneNumber': phone, 'password': password}));

      return response;
    } catch (e) {
      throw Exception('Failed to login professional: $e');
    }
  }

  Future<http.Response> registerInstitution(
      InstitutionModel institution) async {
    try {
      final response = await http.post(
        Uri.parse(ApiUrl.institutionRegistrationUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(institution.toJson()),
      );

      return response;
    } catch (e) {
      throw Exception('Failed to register institution: $e');
    }
  }

  Future<http.Response> loginInstitution(String email, String password) async {
    try {
      final response = await http.post(Uri.parse(ApiUrl.institutionLoginUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({'email': email, 'password': password}));

      return response;
    } catch (e) {
      throw Exception('Failed to login institution: $e');
    }
  }

  Future<http.Response> loginAdmin(String email, String password) async {
    try {
      final response = await http.post(Uri.parse(ApiUrl.adminLoginUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({'email': email, 'password': password}));
      return response;
    } catch (e) {
      throw Exception('Failed to login admin: $e');
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

  Future<http.Response> verifyToken() async {
    final token = await LoginManager.getUserToken();
    final response = await http.post(
      Uri.parse(ApiUrl.tokenVerificationUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    return response;
  }

  Future<http.Response> logout() async {
    final token = await LoginManager.getUserToken();
    final response = await http.post(
      Uri.parse(ApiUrl.logoutUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    return response;
  }
}
