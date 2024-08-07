import 'dart:ui';

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class JournalModel extends Equatable {
  String? id;
  DateTime date;
  String content;
  bool isFavorite;
  String color;

  JournalModel(
      {required this.date,
      required this.content,
      this.isFavorite = false,
      this.id,
      this.color = '#FFFFFF'});

  Color getColor() {
    return Color(int.parse(color.replaceFirst('#', '0xff')));
  }

  void toggleFavorite() {
    isFavorite = !isFavorite;
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'content': content,
      'isFavorite': isFavorite,
      'color': color
    };
  }

  factory JournalModel.fromJson(Map<String, dynamic> json) {
    return JournalModel(
      id: json['_id'] as String,
      date: DateTime.parse(json['date']),
      content: json['content'] as String,
      isFavorite: json['isFavorite'] as bool,
      color: json['color'] as String,
    );
  }
  @override
  List<Object?> get props => [id, date, content, isFavorite, color];
}
