import 'package:app/models/users/client/journal_model.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ClientModel extends Equatable {
  final String? id;
  final String username;
  final String? password;
  final String email;
  final String emergencyContact;
  final String? fullName;
  final String? phoneNumber;
  final DateTime? dateOfBirth;
  final String? nationality;
  final String? residency;
  bool isAnonymous;
  List<JournalModel> journals;

  ClientModel({
    this.id,
    required this.username,
    this.password,
    required this.email,
    required this.emergencyContact,
    this.fullName,
    this.phoneNumber,
    this.dateOfBirth,
    this.nationality,
    this.residency,
    this.isAnonymous = true,
    this.journals = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'email': email,
      'emergencyContact': emergencyContact,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'nationality': nationality,
      'residency': residency,
      'isAnonymous': isAnonymous,
      'journals': journals.map((journal) => journal.toJson()).toList(),
    };
  }

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      id: json['_id'],
      username: json['username'],
      password: json['password'],
      email: json['email'],
      emergencyContact: json['emergencyContact'],
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.parse(json['dateOfBirth'])
          : null,
      nationality: json['nationality'],
      residency: json['residency'],
      isAnonymous: json['isAnonymous'],
      journals: (json['journals'] as List<dynamic>)
          .map((e) => JournalModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        username,
        password,
        email,
        emergencyContact,
        fullName,
        phoneNumber,
        dateOfBirth,
        nationality,
        residency,
        isAnonymous,
        journals,
      ];
}
