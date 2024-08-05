import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class EventModel extends Equatable {
  final String? id;
  final String title;
  final String description;
  final DateTime date;
  final String time;
  String? image;
  final String organizer;
  final List<String> rsvps; // List of user IDs who have RSVP'd

  EventModel({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.organizer,
    this.rsvps = const [],
    this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'image': image,
      'organizer': organizer,
      'rsvps': rsvps,
    };
  }

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      date: json['date'],
      time: json['time'],
      image: json['image'],
      organizer: json['organizer'],
      rsvps: List<String>.from(json['rsvps']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        date,
        time,
        organizer,
        rsvps,
        image,
      ];
}
