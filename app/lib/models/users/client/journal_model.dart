import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class JournalModel extends Equatable {
  String? id;
  DateTime date;
  String content;
  bool isFavorite;

  JournalModel(
      {required this.date,
      required this.content,
      this.isFavorite = false,
      this.id});

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'content': content,
      'isFavorite': isFavorite
    };
  }

  factory JournalModel.fromJson(Map<String, dynamic> json) {
    return JournalModel(
      id: json['_id'] as String,
      date: DateTime.parse(json['date']),
      content: json['content'] as String,
      isFavorite: json['isFavorite'] as bool,
    );
  }
  @override
  List<Object?> get props => throw UnimplementedError();
}
