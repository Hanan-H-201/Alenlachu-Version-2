import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app/core/api.dart' show ApiUrl;
import 'package:app/models/common/post_model.dart';

class PostService {
  Future<http.Response> createPost(PostModel post) async {
    final response = await http.post(
      Uri.parse(ApiUrl.createPostUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(post.toJson()),
    );
    return response;
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
      Uri.parse('${ApiUrl.unlikePIostUrl}?id=$id&userId=$userId'),
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
