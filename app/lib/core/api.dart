class ApiUrl {
  static const String baseUrl = "http://192.168.142.212:3000";

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
  static const String updateProfessionalUrl =
      "$baseUrl/api/professions/updateProfessional";
  static const String adminLoginUrl = "$baseUrl/api/admins/loginAdmin";
  static const String logoutUrl = "$baseUrl/api/logout";
  static const String tokenVerificationUrl = "$baseUrl/api/verify-token";

  static const String createEventUrl = "$baseUrl/api/events/createEvent";
  static const String getEventsUrl = "$baseUrl/api/events/getEvents";
  static const String getEventByIdUrl = "$baseUrl/api/events/getEventById";
  static const String updateEventUrl = "$baseUrl/api/events/updateEvent";
  static const String deleteEventUrl = "$baseUrl/api/events/deleteEvent";
  static const String rsvpEventUrl = "$baseUrl/api/events/rsvpEvent";
  static const String unRsvpEventUrl = "$baseUrl/api/events/unRsvpEvent";

  static const String createAwarenessUrl =
      "$baseUrl/api/awarenesses/createAwareness";
  static const String getAwarenessUrl =
      "$baseUrl/api/awarenesses/getAwarenesses";
  static const String getAwarenessByIdUrl =
      "$baseUrl/api/awarenesses/getAwarnessById";
  static const String updateAwarenessUrl =
      "$baseUrl/api/awarenesses/updateAwareness";
  static const String deleteAwarenessUrl =
      "$baseUrl/api/awarenesses/deleteAwareness";

  static const String addJournalUrl = "$baseUrl/api/clients/addJournal";
  static const String getJournalUrl = "$baseUrl/api/clients/getJournals";
  static const String updateJournalUrl = "$baseUrl/api/clients/updateJournal";
  static const String deleteJournalUrl = "$baseUrl/api/clients/deleteJournal";
  static const String sendAiMessageUrl = "$baseUrl/api/chat/send-message";
  static const String professionalList =
      "$baseUrl/api/professions/professionalList";
  static const String clientDetailsUrl = "$baseUrl/api/realtimechat/clients";
  static const String sendRealtimeMessageUrl =
      "$baseUrl/api/realtimechat/sendMessage";
  static const String getRealtimeMessageUrl =
      "$baseUrl/api/realtimechat/getMessages";

  static const String createPostUrl = "$baseUrl/api/posts/createPost";
  static const String getPostsUrl = "$baseUrl/api/posts/getPosts";
  static const String getPostByIdUrl = "$baseUrl/api/posts/getPostById";
  static const String updatePostUrl = "$baseUrl/api/posts/updatePost";
  static const String deletePostUrl = "$baseUrl/api/posts/deletePost";
  static const String likePostUrl = "$baseUrl/api/posts/likePost";
  static const String unlikePostUrl = "$baseUrl/api/posts/unlikePost";
  static const String getNumberLikesUrl = "$baseUrl/api/posts/getNumberLikes";

  static const String createCommentUrl = "$baseUrl/api/comments/createComment";
  static const String getCommentsUrl = "$baseUrl/api/comments/getComments";
  static const String updateCommentUrl = "$baseUrl/api/comments/updateComment";
  static const String deleteCommentUrl = "$baseUrl/api/comments/deleteComment";
}
