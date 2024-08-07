import 'package:equatable/equatable.dart';

class PostModel extends Equatable {
  final String? id;
  final String
      userId; // Assuming user is represented by its ObjectId as a string
  final String content;
  String? image;
  final List<String>? tags;
  final String privacy;
  final List<String>?
      likes; // Assuming likes are represented by their ObjectId as strings
  final List<String>?
      comments; // Assuming comments are represented by their ObjectId as strings
  final DateTime createdAt;
  final DateTime updatedAt;

  PostModel({
    this.id,
    required this.userId,
    required this.content,
    this.image,
    this.tags,
    required this.privacy,
    this.likes,
    this.comments,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'user': userId,
      'content': content,
      'image': image,
      'tags': tags,
      'privacy': privacy,
      'likes': likes,
      'comments': comments,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['_id'],
      userId: json['user'],
      content: json['content'],
      image: json['image'],
      tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
      privacy: json['privacy'],
      likes: json['likes'] != null ? List<String>.from(json['likes']) : null,
      comments:
          json['comments'] != null ? List<String>.from(json['comments']) : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        content,
        image,
        tags,
        privacy,
        likes,
        comments,
        createdAt,
        updatedAt
      ];
}
