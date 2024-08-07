import 'dart:convert';
import 'package:app/controllers/common/authentication/authentication_state.dart';
import 'package:app/widgets/common/show_toast.dart';
import 'package:app/controllers/common/authentication/authentication_cubit.dart';
import 'package:app/core/api.dart';
import 'package:app/models/common/chat_model.dart';
import 'package:http/http.dart' as http;

// Inject AuthenticationCubit into ChatService
class ChatService {
  final AuthenticationCubit authenticationCubit;

  ChatService({required this.authenticationCubit});

  final String _baseUrl = ApiUrl.baseUrl;

  // Fetch chat history for the current user
  Future<List<ChatMessage>> getChatHistory() async {
    final userId = await _getUserId();
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    final response = await http.get(Uri.parse('$_baseUrl/api/chat/chat-history?userId=$userId'));

    if (response.statusCode == 200) {
      final List<dynamic> chatHistoryJson = json.decode(response.body);
      return chatHistoryJson.map((json) => ChatMessage.fromJson(json)).toList();
    } else {
      showToast(message: response.body);
      throw Exception('Failed to load chat history');
    }
  }

  // Send a message and get a reply from the AI
  Future<String> sendMessage(String message) async {
    final userId = await _getUserId();
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    final response = await http.post(
      Uri.parse(ApiUrl.sendAiMessageUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'message': message,
        'userId': userId,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return responseBody['reply'];
    } else {
      showToast( message: response.body);
      throw Exception('Failed to send message');
    }
  }

  // Get user ID from the AuthenticationCubit state
  Future<String?> _getUserId() async {
    final state = authenticationCubit.state;
    if (state is AuthenticatedAsClient) {
      return state.client.id;  // Ensure that ClientModel has an 'id' field
    } else {
      return null;
    }
  }
}

