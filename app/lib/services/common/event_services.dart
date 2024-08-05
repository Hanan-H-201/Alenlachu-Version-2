import 'dart:convert';

import 'package:app/core/api.dart';
import 'package:app/models/common/event_model.dart';
import 'package:http/http.dart' as http;

class EventServices {
  Future<http.Response> createEvent(EventModel event) async {
    final response = await http.post(Uri.parse(ApiUrl.createEventUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(event.toJson()));

    return response;
  }

  Future<http.Response> getEvents() async {
    final response = await http.get(Uri.parse(ApiUrl.getEventsUrl));
    return response;
  }

  Future<http.Response> getEventById(String id) async {
    final response = await http.get(
      Uri.parse('${ApiUrl.getEventByIdUrl}?id=$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }

  Future<http.Response> updateEvent(String id, EventModel event) async {
    final response = await http.put(
      Uri.parse('${ApiUrl.updateEventUrl}?id=$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(event.toJson()),
    );
    return response;
  }

  Future<http.Response> deleteEvent(String id) async {
    final response = await http.delete(
      Uri.parse('${ApiUrl.deleteEventUrl}?id=$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }

  Future<http.Response> rsvpEvent(String eventId, String userId) async {
    final response = await http.post(
      Uri.parse('${ApiUrl.rsvpEventUrl}?eventId=$eventId&userId=$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }

  Future<http.Response> cancelRsvpEvent(String eventId, String userId) async {
    final response = await http.delete(
      Uri.parse('${ApiUrl.unRsvpEventUrl}?eventId=$eventId&userId=$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }
}
