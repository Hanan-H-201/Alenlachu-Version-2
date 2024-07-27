import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ProfessionModel extends Equatable {
  final String name;
  final String email;
  final String phoneNumber;
  final DateTime dateOfBirth;
  final String nationality;
  final String address;
  final String profession;
  final int exprience;
  final String languageToProvideService;
  final double pricePerHour;
  String verificationStatus;

  ProfessionModel(
      {required this.name,
      required this.email,
      required this.phoneNumber,
      required this.dateOfBirth,
      required this.nationality,
      required this.address,
      required this.profession,
      required this.exprience,
      required this.languageToProvideService,
      required this.pricePerHour,
      this.verificationStatus = 'pending'});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'nationality': nationality,
      'address': address,
      'profession': profession,
      'exprience': exprience,
      'languageToProvideService': languageToProvideService,
      'pricePerHour': pricePerHour,
      'verificationStatus': verificationStatus
    };
  }

  factory ProfessionModel.fromJson(Map<String, dynamic> json) {
    return ProfessionModel(
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
      nationality: json['nationality'],
      address: json['address'],
      profession: json['profession'],
      exprience: json['exprience'],
      languageToProvideService: json['languageToProvideService'],
      pricePerHour: json['pricePerHour'],
      verificationStatus: json['verificationStatus'],
    );
  }
  @override
  List<Object?> get props => [
        name,
        email,
        phoneNumber,
        dateOfBirth,
        nationality,
        address,
        profession,
        exprience,
        languageToProvideService,
        pricePerHour,
        verificationStatus
      ];
}
