import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class InstitutionModel extends Equatable {
  String? id;
  final String name;
  final String email;
  final String phoneNumber;
  final String address;
  final DateTime establishmentDate;
  final String languageToProvideService;
  final double pricePerHour;

  InstitutionModel(
      {this.id,
      required this.name,
      required this.email,
      required this.phoneNumber,
      required this.address,
      required this.establishmentDate,
      required this.languageToProvideService,
      required this.pricePerHour});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
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
        phoneNumber,
        address,
        establishmentDate,
        languageToProvideService,
        pricePerHour
      ];
}
