import 'dart:convert';

import 'package:app/core/api.dart';
import 'package:app/models/common/awareness_model.dart';
import 'package:http/http.dart' as http;

class AwarenessService {
  Future<http.Response> createAwareness(AwarenessModel awareness) async {
    final response = await http.post(Uri.parse(ApiUrl.createAwarenessUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(awareness.toJson()));
    return response;
  }

  Future<http.Response> getAllAwareness() async {
    final response = await http.get(Uri.parse(ApiUrl.getAwarenessUrl));
    return response;
  }

  Future<http.Response> getAwarenessById(String id) async {
    final response =
        await http.get(Uri.parse('${ApiUrl.getAwarenessByIdUrl}?id=$id'));
    return response;
  }

  Future<http.Response> updateAwareness(
      String id, AwarenessModel awareness) async {
    final response =
        await http.put(Uri.parse('${ApiUrl.updateAwarenessUrl}?id=$id'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(awareness.toJson()));
    return response;
  }

  Future<http.Response> deleteAwareness(String id) async {
    final response =
        await http.delete(Uri.parse('${ApiUrl.deleteAwarenessUrl}?id=$id'));
    return response;
  }
}
