import 'package:equatable/equatable.dart';

class CommentModel extends Equatable {
  final String? id;
  final String
      userId; // Assuming user is represented by its ObjectId as a string
  final String
      postId; // Assuming post is represented by its ObjectId as a string
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;

  CommentModel({
    this.id,
    required this.userId,
    required this.postId,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'user': userId,
      'post': postId,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['_id'],
      userId: json['user'],
      postId: json['post'],
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  @override
  List<Object?> get props =>
      [id, userId, postId, content, createdAt, updatedAt];
}
