import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class ProfessionalsState extends Equatable {
  @override
  List<Object> get props => [];
}

final class ProfessionalsInitial extends ProfessionalsState {}

final class UploadindLicense extends ProfessionalsState {}

final class LicenseUploaded extends ProfessionalsState {
  final File? file;
  final String? filename;

  LicenseUploaded({required this.file, required this.filename});

  @override
  List<Object> get props => [file!, filename!];
}

final class LicenseUploadFailed extends ProfessionalsState {
  final String error;

  LicenseUploadFailed({required this.error});

  @override
  List<Object> get props => [error];
}

final class ProcessingData extends ProfessionalsState {}

final class VerifiedProfessional extends ProfessionalsState {}
