class ApiUrl {
  static const String baseUrl = "http://192.168.110.212:3000";
  static const String clientRegistrationUrl =
      "$baseUrl/api/clients/registerClient";
  static const String institutionRegistrationUrl =
      "$baseUrl/api/institutions/registerInstitution";
  static const String professionalsRegistrationUrl =
      "$baseUrl/api/professions/registerProfession";
  static const String logoutUrl = "$baseUrl/api/logout";
}
