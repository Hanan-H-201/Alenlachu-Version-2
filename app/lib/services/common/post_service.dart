import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app/core/api.dart' show ApiUrl;
import 'package:app/models/common/post_model.dart';

class PostService {
  Future<http.Response> createPost({
    required String content,
    required String tags,
    required String privacy,
    required String image,
    required String userId,
  }) async {
    final url = Uri.parse(ApiUrl.createPostUrl);
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final body = jsonEncode(<String, dynamic>{
      'content': content,
      'tags': tags.split(','), // Convert comma-separated string to list
      'privacy': privacy,
      'image': image,
      'userId': userId,
    });

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 201) {
        return response;
      } else {
        throw Exception(
            'Failed to create post. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error creating post: $e');
    }
  }

  Future<http.Response> getAllPosts() async {
    final response = await http.get(Uri.parse(ApiUrl.getPostsUrl));
    return response;
  }

  Future<http.Response> getPostById(String id) async {
    final response =
        await http.get(Uri.parse('${ApiUrl.getPostByIdUrl}?id=$id'));
    return response;
  }

  Future<http.Response> updatePost(String id, PostModel post) async {
    final response = await http.put(
      Uri.parse('${ApiUrl.updatePostUrl}?id=$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(post.toJson()),
    );
    return response;
  }

  Future<http.Response> deletePost(String id) async {
    final response =
        await http.delete(Uri.parse('${ApiUrl.deletePostUrl}?id=$id'));
    return response;
  }

  Future<http.Response> likePost(String id, String userId) async {
    final response = await http.put(
      Uri.parse('${ApiUrl.likePostUrl}?id=$id&userId=$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }

  Future<http.Response> unlikePost(String id, String userId) async {
    final response = await http.put(
      Uri.parse('${ApiUrl.unlikePostUrl}?id=$id&userId=$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }

  Future<int> getNumberLikes(String id) async {
    final response =
        await http.get(Uri.parse('${ApiUrl.getNumberLikesUrl}?id=$id'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['numberOfLikes'];
    } else {
      throw Exception('Failed to load number of likes');
    }
  }
}
