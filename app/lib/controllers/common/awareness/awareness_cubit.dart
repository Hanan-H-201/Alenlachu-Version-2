import 'dart:convert';

import 'package:app/controllers/common/awareness/awareness_state.dart';
import 'package:app/models/common/awareness_model.dart';
import 'package:app/services/common/awareness_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AwarenessCubit extends Cubit<AwarenessState> {
  final AwarenessService awarenessService;
  AwarenessCubit({required this.awarenessService}) : super(AwarenessInitial());

  Future<void> getAllAwareness() async {
    emit(AwarenessLoading());
    try {
      final response = await awarenessService.getAllAwareness();
      final jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        List<Map<String, dynamic>> awarenessData =  List<Map<String, dynamic>>.from(jsonResponse);
        List<AwarenessModel> awareness = awarenessData.map((json) => AwarenessModel.fromJson(json)).toList();


        emit(AwarenessLoaded(awarenesses: awareness));
      } else {
        emit(AwarenessOperationError(error: jsonResponse['error']));
      }
    } catch (e) {
      emit(AwarenessOperationError(error: e.toString()));
    }
  }

  Future<void> createAwareness(
      {required String title,
      required String content,
      required DateTime createdDate,
      required String source}) async {
    emit(AwarenessLoading());
    try {
      AwarenessModel newAwareness = AwarenessModel(
          title: title,
          content: content,
          createdDate: createdDate,
          source: source);
      final response = await awarenessService.createAwareness(newAwareness);
      if (response.statusCode == 201) {
        emit(
            AwarenessOperationSuccess(success: "Lesson Created Successfully!"));
      } else {
        emit(
            AwarenessOperationError(error: jsonDecode(response.body)['error']));
      }
    } catch (e) {
      emit(AwarenessOperationError(error: e.toString()));
    }
  }

  Future<void> updateAwareness(AwarenessModel awareness) async {
    emit(AwarenessLoading());
    try {
      final response =
          await awarenessService.updateAwareness(awareness.id!, awareness);
      if (response.statusCode == 200) {
        emit(AwarenessOperationSuccess(
            success: "Awareness Updated Successfully!"));
      } else {
        emit(
            AwarenessOperationError(error: jsonDecode(response.body)['error']));
      }
    } catch (e) {
      emit(AwarenessOperationError(error: e.toString()));
    }
  }

  Future<void> deleteAwareness(String id) async {
    emit(AwarenessLoading());
    try {
      final response = await awarenessService.deleteAwareness(id);
      if (response.statusCode == 200) {
        emit(AwarenessOperationSuccess(
            success: "Awareness Deleted Successfully!"));
      } else {
        emit(
            AwarenessOperationError(error: jsonDecode(response.body)['error']));
      }
    } catch (e) {
      emit(AwarenessOperationError(error: e.toString()));
    }
  }
}
