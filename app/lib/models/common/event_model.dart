import 'package:equatable/equatable.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class EventModel extends Equatable {
  final String? id;
  final String title;
  final String description;
  final DateTime date;
  final String time;
  String? image;
  final String organizer;
  final String location;
  final List<String> rsvps; // List of user IDs who have RSVP'd

  EventModel({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.organizer,
    required this.location,
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
      'location': location,
      'rsvps': rsvps,
    };
  }

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      time: json['time'],
      image: json['image'],
      organizer: json['organizer'],
      location: json['location'],
      rsvps: List<String>.from(json['rsvps']),
    );
  }

  String get mapsUrl {
    final query = Uri.encodeComponent(location);
    return 'https://www.google.com/maps/search/?api=1&query=$query';
  }

  Future<void> openMaps() async {
    final url = Uri.parse(mapsUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
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
