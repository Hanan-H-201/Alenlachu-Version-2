class ApiUrl {
  static const String baseUrl = "http://192.168.110.212:3000";
  static const String clientRegistrationUrl =
      "$baseUrl/api/clients/registerClient";
  static const String institutionRegistrationUrl =
      "$baseUrl/api/institutions/registerInstitution";
  static const String professionalsRegistrationUrl =
      "$baseUrl/api/professions/registerProfession";
  static const String adminRegistrationUrl =
      "$baseUrl/api/admins/registerAdmin";
  static const String clientLoginUrl = "$baseUrl/api/clients/loginClient";
  static const String institutionLoginUrl =
      "$baseUrl/api/institutions/loginInstitution";
  static const String professionalLoginUrl =
      "$baseUrl/api/professions/loginProfessional";
  static const String adminLoginUrl = "$baseUrl/api/admins/loginAdmin";
  static const String logoutUrl = "$baseUrl/api/logout";
  static const String tokenVerificationUrl = "$baseUrl/api/verify-token";
}
