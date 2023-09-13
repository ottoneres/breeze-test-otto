import 'package:json_annotation/json_annotation.dart';

part 'matched_user.g.dart';

@JsonSerializable()
class MatchedUser {
  /// Constructor for a [MatchedUser]; acts as one of the users in the [Match] instance.
  const MatchedUser({
    required this.id,
    required this.userId,
    required this.name,
    required this.photo,
  });

  /// The uuid of this matched user.
  final String id;

  /// The id of the user, used to know if this is this user or the other user.
  final String userId;

  /// The name of the user.
  final String name;

  /// The profile photo of the user.
  final String photo;

  factory MatchedUser.fromJson(Map<String, dynamic> json) =>
      _$MatchedUserFromJson(json);

  Map<String, dynamic> toJson() => _$MatchedUserToJson(this);

  @override
  int get hashCode => id.hashCode ^ userId.hashCode;

  @override
  bool operator ==(Object other) =>
      other is MatchedUser && other.id == id && other.userId == userId;

  @override
  String toString() => toJson().toString();
}
