class ApiRoutes {
  /// The url used to obtain all matches.
  static const String matches = 'matches';

  /// The url used to obtain an individual match by [id].
  static String matchById(String id) => 'matches/$id';

  /// The url used to obtain the payment link for the match with the provided [matchId].
  static String paymentForMatch(String matchId) => 'matches/$matchId/payment';

  static String availabilityForMatch(String matchId) => 'matches/$matchId/availability';

  static String confirmPresenceForMatch(String matchId) => 'matches/$matchId/confirm';
}
