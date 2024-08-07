import 'dart:convert';

import 'package:app/core/api.dart';
import 'package:http/http.dart' as http;

class JournalServices {
  Future<http.Response> addJournal(
      String clientId, Map<String, dynamic> journalData) async {
    final response =
        http.post(Uri.parse('${ApiUrl.addJournalUrl}?clientId=$clientId'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(journalData));
    return response;
  }

  Future<http.Response> getJournals(String clientId) {
    final response =
        http.get(Uri.parse('${ApiUrl.getJournalUrl}?clientId=$clientId'));
    return response;
  }

  Future<http.Response> updateJournal(String clientId, String journalId,
      Map<String, dynamic> journalData) async {
    final response = http.put(
        Uri.parse(
            '${ApiUrl.updateJournalUrl}?clientId=$clientId&journalId=$journalId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(journalData));
    return response;
  }

  Future<http.Response> deleteJournal(String clientId, String journalId) {
    final response = http.delete(Uri.parse(
        '${ApiUrl.deleteJournalUrl}?clientId=$clientId&journalId=$journalId'));
    return response;
  }
}
