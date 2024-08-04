import 'package:equatable/equatable.dart';

class AdminModel extends Equatable {
  final String email;
  final String? password;

  const AdminModel({required this.email, this.password});

  Map<String, dynamic> toJSon() {
    return {'email': email, 'password': password};
  }

  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(email: json['email'], password: json['password']);
  }

  @override
  List<Object?> get props => [email, password];
}
