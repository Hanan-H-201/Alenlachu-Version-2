import 'package:equatable/equatable.dart';

class InstitutionModel extends Equatable {
  final String name;
  final String email;
  final String phoneNumber;
  final String address;
  final DateTime establishmentDate;
  final String languageToProvideService;
  final double pricePerHour;

  const InstitutionModel(
      {required this.name,
      required this.email,
      required this.phoneNumber,
      required this.address,
      required this.establishmentDate,
      required this.languageToProvideService,
      required this.pricePerHour});

  Map<String, dynamic> toJson() {
    return {
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
        name,
        email,
        phoneNumber,
        address,
        establishmentDate,
        languageToProvideService,
        pricePerHour
      ];
}
