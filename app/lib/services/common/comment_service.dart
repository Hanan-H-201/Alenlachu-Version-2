import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app/core/api.dart';

class CommentService {
  // Add a comment
  Future<void> addComment(String postId, String userId, String content) async {
    final response = await http.post(
      Uri.parse('${ApiUrl.createCommentUrl}?postId=$postId&userId=$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'content': content,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add comment');
    }
  }

  // Get comments for a post
  Future<List<dynamic>> getComments(String postId) async {
    final response = await http.get(
      Uri.parse('${ApiUrl.getCommentsUrl}?postId=$postId'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load comments');
    }
  }

  // Update a comment
  Future<void> updateComment(
      String commentId, String userId, String content) async {
    final response = await http.put(
      Uri.parse('${ApiUrl.updateCommentUrl}?userId=$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'content': content,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update comment');
    }
  }

  // Delete a comment
  Future<void> deleteComment(String commentId, String userId) async {
    final response = await http.delete(
      Uri.parse('${ApiUrl.deleteCommentUrl}?userId=$userId'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete comment');
    }
  }
}
