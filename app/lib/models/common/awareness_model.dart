import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class AwarenessModel extends Equatable {
  final String? id;
  final String title;
  final String content;
  String? image;
  final DateTime createdDate;
  final String source;

  AwarenessModel({
    this.id,
    required this.title,
    required this.content,
    this.image,
    required this.createdDate,
    required this.source,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'createdDate':
          createdDate.toIso8601String(), // Convert DateTime to ISO8601 string
      'image': image,
      'source': source
    };
  }

  factory AwarenessModel.fromJson(Map<String, dynamic> json) {
    return AwarenessModel(
      id: json['_id'],
      title: json['title'],
      content: json['content'],
      createdDate: DateTime.parse(
          json['createdDate']), // Parse ISO8601 string to DateTime
      image: json['image'],
      source: json['source'],
    );
  }

  @override
  List<Object?> get props => [id, title, content, createdDate, image, source];
}
