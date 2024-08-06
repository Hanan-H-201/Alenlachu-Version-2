import 'dart:convert';

import 'package:app/controllers/common/event/event_state.dart';
import 'package:app/models/common/event_model.dart';
import 'package:app/services/common/event_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class EventCubit extends Cubit<EventState> {
  final EventServices eventServices;
  EventCubit({required this.eventServices}) : super(EventInitial());

  Future<void> getEvents() async {
    emit(EventLoading());
    try {
      http.Response response = await eventServices.getEvents();

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        List<Map<String, dynamic>> eventData =
            List<Map<String, dynamic>>.from(jsonResponse);
        List<EventModel> events =
            eventData.map((json) => EventModel.fromJson(json)).toList();
        emit(EventLoaded(events: events));
      }
    } catch (e) {
      emit(EventError(error: e.toString()));
    }
  }

  Future<void> createEvent(
      {required String title,
      required String description,
      required DateTime date,
      required String time,
      required String organizer,
      required String location}) async {
    emit(EventLoading());
    EventModel newEvent = EventModel(
        title: title,
        description: description,
        date: date,
        time: time,
        organizer: organizer,
        location: location);

    try {
      http.Response response = await eventServices.createEvent(newEvent);
      if (response.statusCode == 201) {
        emit(EventSucceeded(success: "Event Created!"));
      } else {
        emit(EventError(error: 'Failed to create event'));
      }
    } catch (e) {
      emit(EventError(error: e.toString()));
    }
  }

  Future<void> updateEvent(EventModel event) async {
    emit(EventLoading());
    try {
      http.Response response =
          await eventServices.updateEvent(event.id!, event);
      if (response.statusCode == 200) {
        emit(EventSucceeded(success: "Event Updated!"));
      } else {
        emit(EventError(error: 'Failed to update event'));
      }
    } catch (e) {
      emit(EventError(error: e.toString()));
    }
  }

  Future<void> deleteEvent(String id) async {
    emit(EventLoading());
    try {
      http.Response response = await eventServices.deleteEvent(id);
      if (response.statusCode == 200) {
        emit(EventSucceeded(success: "Event Deleted!"));
      } else {
        emit(EventError(error: 'Failed to delete event'));
      }
    } catch (e) {
      emit(EventError(error: e.toString()));
    }
  }

  Future<void> rsvpEvent(String eventId, String userId) async {
    try {
      http.Response response = await eventServices.rsvpEvent(eventId, userId);
      if (response.statusCode == 200) {
        emit(EventSucceeded(success: "Event RSVP successful!"));
      } else {
        emit(EventError(error: 'Failed to RSVP event'));
      }
    } catch (e) {
      emit(EventError(error: e.toString()));
    }
  }

  Future<void> cancelRsvpEvent(String eventId, String userId) async {
    try {
      http.Response response =
          await eventServices.cancelRsvpEvent(eventId, userId);
      if (response.statusCode == 200) {
        emit(EventSucceeded(success: "Event RSVP successful!"));
      } else {
        emit(EventError(error: 'Failed to RSVP event'));
      }
    } catch (e) {
      emit(EventError(error: e.toString()));
    }
  }
}
