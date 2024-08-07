import 'dart:convert';

import 'package:app/controllers/client/journal/journal_state.dart';
import 'package:app/controllers/common/authentication/authentication_cubit.dart';
import 'package:app/controllers/common/authentication/authentication_state.dart';
import 'package:app/models/users/client/journal_model.dart';
import 'package:app/services/client/journal_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class JournalCubit extends Cubit<JournalState> {
  final JournalServices journalServices;
  final AuthenticationCubit authenticationCubit;
  JournalCubit(
      {required this.journalServices, required this.authenticationCubit})
      : super(JournalInitial());

  Future<void> addJournal({
    required DateTime date,
    required String content,
    required String color,
  }) async {
    emit(JournalLoading());
    try {
      final client =
          (authenticationCubit.state as AuthenticatedAsClient).client;
      final clientId = client.id;
      JournalModel newJournal =
          JournalModel(date: date, content: content, color: color);
      http.Response response =
          await journalServices.addJournal(clientId!, newJournal.toJson());
      if (response.statusCode == 201) {
        emit(JournalOperationSuccess(message: "Journal Added!"));
        getJournals();
      } else {
        final jsonResponse = jsonDecode(response.body);
        emit(JournalOperationError(message: jsonResponse['error']));
      }
    } catch (e) {
      emit(JournalOperationError(message: e.toString()));
    }
  }

  Future<void> getJournals() async {
    try {
      emit(JournalLoading());
      final client =
          (authenticationCubit.state as AuthenticatedAsClient).client;
      final clientId = client.id;
      http.Response response = await journalServices.getJournals(clientId!);
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        List<Map<String, dynamic>> journalData =
            List<Map<String, dynamic>>.from(jsonResponse);
        List<JournalModel> journals =
            journalData.map((json) => JournalModel.fromJson(json)).toList();

        emit(JournalLoaded(journals: journals));
      } else {
        final jsonResponse = jsonDecode(response.body);
        emit(JournalOperationError(message: jsonResponse['error']));
      }
    } catch (e) {
      emit(JournalOperationError(message: e.toString()));
    }
  }

  Future<void> updateJournal({required JournalModel updatedJournal}) async {
    emit(JournalLoading());
    try {
      final client =
          (authenticationCubit.state as AuthenticatedAsClient).client;
      final clientId = client.id;
      http.Response response = await journalServices.updateJournal(
          clientId!, updatedJournal.id!, updatedJournal.toJson());
      if (response.statusCode == 200) {
        emit(JournalOperationSuccess(message: "Journal Updated!"));
        getJournals();
      } else {
        final jsonResponse = jsonDecode(response.body);
        emit(JournalOperationError(message: jsonResponse['error']));
      }
    } catch (e) {
      emit(JournalOperationError(message: e.toString()));
    }
  }

  Future<void> deleteJournal({required String journalId}) async {
    emit(JournalLoading());
    try {
      final client =
          (authenticationCubit.state as AuthenticatedAsClient).client;
      final clientId = client.id;
      http.Response response =
          await journalServices.deleteJournal(clientId!, journalId);
      if (response.statusCode == 200) {
        emit(JournalOperationSuccess(message: "Journal Deleted!"));
      } else {
        final jsonResponse = jsonDecode(response.body);
        emit(JournalOperationError(message: jsonResponse['error']));
      }
    } catch (e) {
      emit(JournalOperationError(message: e.toString()));
    }
  }
}
