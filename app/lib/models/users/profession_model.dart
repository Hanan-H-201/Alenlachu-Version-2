import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ProfessionModel extends Equatable {
  final String? id;
  final String name;
  final String email;
  final String password;
  final String phoneNumber;
  final DateTime dateOfBirth;
  final String nationality;
  final String address;
  final String profession;
  final int experience;
  final String languageToProvideService;
  final double pricePerHour;
  String verificationStatus;

  ProfessionModel(
      {this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.phoneNumber,
      required this.dateOfBirth,
      required this.nationality,
      required this.address,
      required this.profession,
      required this.experience,
      required this.languageToProvideService,
      required this.pricePerHour,
      this.verificationStatus = 'pending'});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'nationality': nationality,
      'address': address,
      'profession': profession,
      'experience': experience,
      'languageToProvideService': languageToProvideService,
      'pricePerHour': pricePerHour,
      'verificationStatus': verificationStatus
    };
  }

  factory ProfessionModel.fromJson(Map<String, dynamic> json) {
    return ProfessionModel(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      phoneNumber: json['phoneNumber'],
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
      nationality: json['nationality'],
      address: json['address'],
      profession: json['profession'],
      experience: json['experience'],
      languageToProvideService: json['languageToProvideService'],
      pricePerHour: json['pricePerHour'],
      verificationStatus: json['verificationStatus'],
    );
  }
  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phoneNumber,
        dateOfBirth,
        nationality,
        address,
        profession,
        experience,
        languageToProvideService,
        pricePerHour,
        verificationStatus
      ];
}
