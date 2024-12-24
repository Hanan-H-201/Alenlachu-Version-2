import 'dart:convert';
import 'package:http/http.dart' as http;

class VentingService {
  final String baseUrl = 'http://10.0.2.2:5000/api/messages';

  Future<List<Map<String, dynamic>>> fetchMessages() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data
            .map((message) => {
          'id': message['id'],
          'text': message['text'],
          'timestamp': message['timestamp'],
        })
            .toList();
      } else {

        throw Exception('Failed to fetch messages');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> sendMessage(String text) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'text': text}),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to send message');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> editMessage(String id, String newText) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'text': newText}),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to edit message');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
