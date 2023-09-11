import 'package:breeze_case/core/constants/user_id.dart';
import 'package:breeze_case/core/models/matched_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'match.g.dart';

@JsonSerializable()
class Match {
  /// The uuid of this match.
  final String id;

  /// The moment the match was created.
  final DateTime createdAt;

  /// The two users in it, of which one is the current user.
  final List<MatchedUser> matchedUsers;

  /// The name of the city where the date will take place.
  final String city;

  /// The name of the type of date that will be organized.
  final String dealType;

  /// Set if the [plannedOn] is set.
  final String? deal;

  /// The planned date and time when the date will take place.
  final DateTime? plannedOn;

  /// Set if paid to the moment of paying.
  final DateTime? paidAt;

  /// Set if given availability to the moment of the action.
  final DateTime? availabilityGivenAt;

  /// Set if confirmed to the moment of confirming.
  final int? confirmedAt;

  /// Constructor for a [Match] between two users.
  const Match(
      {required this.id,
      required this.createdAt,
      required this.matchedUsers,
      required this.city,
      required this.dealType,
      this.deal,
      this.plannedOn,
      this.paidAt,
      this.availabilityGivenAt,
      this.confirmedAt});

  /// Returns the current user in the match.
  MatchedUser get thisUser => matchedUsers.firstWhere((mu) => mu.userId == userId);

  /// Returns the other user in the match.
  MatchedUser get otherUser => matchedUsers.firstWhere((mu) => mu.userId != userId);

  factory Match.fromJson(Map<String, dynamic> json) => _$MatchFromJson(json);

  Map<String, dynamic> toJson() => _$MatchToJson(this);

  /// Returns a list of [Match] objects when provided with serialized JSON containing a list.
  static List<Match> fromList(List<dynamic>? json) =>
      json?.map((e) => Match.fromJson(e! as Map<String, dynamic>)).toList() ?? [];

  @override
  bool operator ==(Object other) => other is Match && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => toJson().toString();
}
