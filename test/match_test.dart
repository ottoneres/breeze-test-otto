import 'package:breeze_case/core/constants/user_id.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:breeze_case/core/models/match.dart';
import 'package:breeze_case/core/models/matched_user.dart';

void main() {
  group('Test_MatchClass', () {
    late Match testMatch;
    late Match testMatchConfirmedAt;
    late List<MatchedUser> matchedUsers;
    late DateTime createdAt;
    late String city;
    late String dealType;

    setUp(() {
      createdAt = DateTime.now();
      matchedUsers = [
        const MatchedUser(
            userId: userId,
            id: 'match758',
            name: 'Otto',
            photo: 'https://avatars.githubusercontent.com/u/68795143?v=4'),
        const MatchedUser(
            userId: 'other_user_id',
            id: 'match758',
            name: 'Anouk',
            photo: 'https://avatars.githubusercontent.com/u/68795143?v=4'),
      ];
      city = 'Utrecht';
      dealType = "walkAndTalk";

      testMatch = Match(
        id: 'match758',
        createdAt: createdAt,
        matchedUsers: matchedUsers,
        city: city,
        dealType: dealType,
      );

      testMatchConfirmedAt = Match(
        id: 'match758',
        createdAt: createdAt,
        matchedUsers: matchedUsers,
        city: city,
        dealType: dealType,
        confirmedAt: DateTime.now(),
      );
    });

    test('Match should have confirmedAt as DateTime', () {
      expect(testMatchConfirmedAt.confirmedAt, isA<DateTime>());
    });

    test('Match should have correct properties', () {
      expect(testMatch.id, 'match758');
      expect(testMatch.createdAt, isA<DateTime>());
      expect(testMatch.matchedUsers, matchedUsers);
      expect(testMatch.city, 'Utrecht');
      expect(testMatch.dealType, 'walkAndTalk');
      expect(testMatch.deal, isNull);
      expect(testMatch.plannedOn, isNull);
      expect(testMatch.paidAt, isNull);
      expect(testMatch.availabilityGivenAt, isNull);
      expect(testMatch.confirmedAt, isNull);
    });

    test('Match should return thisUser correctly', () {
      expect(testMatch.thisUser.userId, userId);
      expect(testMatch.thisUser, testMatch.matchedUsers[0]);
    });

    test('Match should return otherUser correctly', () {
      expect(testMatch.otherUser.userId, isNot(userId));
      expect(testMatch.otherUser, testMatch.matchedUsers[1]);
    });

    test('Match should serialize to JSON correctly', () {
      final json = testMatch.toJson();
      expect(json['id'], 'match758');
      expect(json['createdAt'], isA<String>());
      expect(json['matchedUsers'], isA<List>());
      expect(json['city'], 'Utrecht');
      expect(json['dealType'], 'walkAndTalk');
      expect(json['deal'], isNull);
      expect(json['plannedOn'], isNull);
      expect(json['paidAt'], isNull);
      expect(json['availabilityGivenAt'], isNull);
      expect(json['confirmedAt'], isNull);
    });

    test('Match should deserialize from JSON correctly', () {
      final json = {
        'id': 'matchId',
        'createdAt': DateTime.now().toIso8601String(),
        'matchedUsers': matchedUsers.map((mu) => mu.toJson()).toList(),
        'city': 'New York',
        'dealType': 'Restaurant',
      };
      final deserializedMatch = Match.fromJson(json);
      expect(deserializedMatch.id, 'matchId');
      expect(deserializedMatch.createdAt, isA<DateTime>());
      expect(deserializedMatch.matchedUsers, matchedUsers);
      expect(deserializedMatch.city, 'New York');
      expect(deserializedMatch.dealType, 'Restaurant');
      expect(deserializedMatch.deal, isNull);
      expect(deserializedMatch.plannedOn, isNull);
      expect(deserializedMatch.paidAt, isNull);
      expect(deserializedMatch.availabilityGivenAt, isNull);
      expect(deserializedMatch.confirmedAt, isNull);
    });

    test('Match.fromList should return a list of Match objects', () {
      final jsonList = [
        {
          'id': 'matchId1',
          'createdAt': DateTime.now().toIso8601String(),
          'matchedUsers': matchedUsers.map((mu) => mu.toJson()).toList(),
          'city': 'New York',
          'dealType': 'Restaurant',
        },
        {
          'id': 'matchId2',
          'createdAt': DateTime.now().toIso8601String(),
          'matchedUsers': matchedUsers.map((mu) => mu.toJson()).toList(),
          'city': 'Los Angeles',
          'dealType': 'Movie',
        },
      ];
      final matches = Match.fromList(jsonList);
      expect(matches.length, 2);
      expect(matches[0].id, 'matchId1');
      expect(matches[1].id, 'matchId2');
    });

    test('Match should have correct hashCode and equality', () {
      final match1 = Match(
        id: 'matchId',
        createdAt: DateTime.now(),
        matchedUsers: matchedUsers,
        city: 'New York',
        dealType: 'Restaurant',
      );
      final match2 = Match(
        id: 'matchId',
        createdAt: DateTime.now(),
        matchedUsers: matchedUsers,
        city: 'New York',
        dealType: 'Restaurant',
      );
      expect(match1.hashCode, match2.hashCode);
      expect(match1, match2);
    });

    test('Match should have correct string representation', () {
      final matchString = testMatch.toString();
      expect(matchString, isA<String>());
      expect(matchString.contains('matchedUsers'), true);
      expect(matchString.contains('match758'), true);
    });
  });
}
