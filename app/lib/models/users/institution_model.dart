import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class InstitutionModel extends Equatable {
  final String? id;
  final String name;
  final String email;
  final String password;
  final String phoneNumber;
  final String address;
  final DateTime establishmentDate;
  final String languageToProvideService;
  final double pricePerHour;

  const InstitutionModel(
      {this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.phoneNumber,
      required this.address,
      required this.establishmentDate,
      required this.languageToProvideService,
      required this.pricePerHour});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'address': address,
      'establishmentDate': establishmentDate.toIso8601String(),
      'languageToProvideService': languageToProvideService,
      'pricePerHour': pricePerHour
    };
  }

  factory InstitutionModel.fromJson(Map<String, dynamic> json) {
    return InstitutionModel(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      establishmentDate: DateTime.parse(json['establishmentDate']),
      languageToProvideService: json['languageToProvideService'],
      pricePerHour: json['pricePerHour'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        password,
        phoneNumber,
        address,
        establishmentDate,
        languageToProvideService,
        pricePerHour
      ];
}
