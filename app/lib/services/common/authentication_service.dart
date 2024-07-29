import 'dart:convert';

import 'package:app/core/api.dart';
import 'package:app/models/users/client_model.dart';
import 'package:app/models/users/institution_model.dart';
import 'package:app/models/users/profession_model.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse["status"]) {
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('token', jsonResponse["token"]);
          Map<String, dynamic> jwtDecodedToken =
              JwtDecoder.decode(jsonResponse["token"]);
          return ClientModel.fromJson(jwtDecodedToken);
        }
      }
    } catch (e) {
      throw Exception('Failed to register client: $e');
    }
    return null;
  }

  Future<void> registerProfessional(ProfessionModel professional) async {}

  Future<void> registerInstitution(InstitutionModel institution) async {}

  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // final token = prefs.getString('token');
      // final response = await http.post(
      //   Uri.parse(ApiUrl.logoutUrl),
      //   headers: {
      //     'Authorization': 'Bearer $token',
      //     'Content-Type': 'application/json',
      //   },
      // );
      await prefs.remove('token');
    } catch (e) {
      throw Exception('Failed to logout: $e');
    }
  }
}
