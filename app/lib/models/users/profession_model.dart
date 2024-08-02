import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ProfessionModel extends Equatable {
  final String? id;
  final String name;
  final String email;
  final String? password;
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
      this.password,
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
      id: json['_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'],
      phoneNumber: json['phoneNumber'] as String,
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
      nationality: json['nationality'] as String,
      address: json['address'] as String,
      profession: json['profession'] as String,
      experience: json['experience'] is int
          ? json['experience'] as int
          : int.parse(json['experience'].toString()),
      languageToProvideService: json['languageToProvideService'] as String,
      pricePerHour: json['pricePerHour'] is double
          ? json['pricePerHour'] as double
          : double.parse(json['pricePerHour'].toString()),
      verificationStatus: json['verificationStatus'] as String,
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
