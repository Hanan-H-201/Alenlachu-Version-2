import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ClientModel extends Equatable {
  final String? id;
  final String username;
  final String password;
  final String email;
  final String emergencyContact;
  final String? fullName;
  final String? phoneNumber;
  final DateTime? dateOfBirth;
  final String? nationality;
  final String? residency;
  bool isAnonymous;

  ClientModel({
    this.id,
    required this.username,
    required this.password,
    required this.email,
    required this.emergencyContact,
    this.fullName,
    this.phoneNumber,
    this.dateOfBirth,
    this.nationality,
    this.residency,
    this.isAnonymous = true,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'email': email,
      'emergencyContact': emergencyContact,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'nationality': nationality,
      'residency': residency,
      'isAnonymous': isAnonymous
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
        isAnonymous
      ];
}
