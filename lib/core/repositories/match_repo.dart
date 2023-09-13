import 'package:breeze_case/core/api/api_response.dart';
import 'package:breeze_case/core/constants/api_routes.dart';
import 'package:breeze_case/core/models/match.dart';
import 'package:breeze_case/core/api/api.dart';

class MatchRepository {
  MatchRepository({required this.api});

  final Api api;

  List<Match> matches = [];

  /// Updates the [matches] list with the latest matches from the [Api]. When unsuccessful, it will return `false`.
  Future<bool> getMatches() async {
    final ApiResponse response = await api.get(ApiRoutes.matches);
    if (!response.isSuccessful) return false;
    try {
      final List<Match> matches = Match.fromList((response.data));
      this.matches = matches;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> payForMatchById(String matchId) async {
    final int matchIndex = matches.indexWhere((match) => match.id == matchId);
    if (matchIndex == -1) return false;

    final ApiResponse response =
        await api.get(ApiRoutes.paymentForMatch(matchId));
    if (response.isSuccessful) await _getMatchesById(matchId);
    return response.isSuccessful;
  }

  Future<bool> setAvailabilityGivenForMatchById(String matchId) async {
    final int matchIndex = matches.indexWhere((match) => match.id == matchId);
    if (matchIndex == -1) return false;

    final ApiResponse response =
        await api.post(ApiRoutes.availabilityForMatch(matchId), {});
    if (response.isSuccessful) await _getMatchesById(matchId);
    return response.isSuccessful;
  }

  Future<bool> setConfirmedAtForMatchById(String matchId) async {
    final int matchIndex = matches.indexWhere((match) => match.id == matchId);
    if (matchIndex == -1) return false;

    final ApiResponse response =
        await api.put(ApiRoutes.confirmPresenceForMatch(matchId), {});
    if (response.isSuccessful) await _getMatchesById(matchId);
    return response.isSuccessful;
  }

  /// Updates the [matches] list only for the [Match] with the provided [id] with the latest data from the [Api].
  /// When unsuccessful, it will return `false`.
  Future<bool> _getMatchesById(String id) async {
    final int matchIndex = matches.indexWhere((match) => match.id == id);
    if (matchIndex == -1) return false;

    final ApiResponse response = await api.get(ApiRoutes.matchById(id));
    try {
      final Match updatedMatch = Match.fromJson(response.data);
      matches[matchIndex] = updatedMatch;
      return true;
    } catch (e) {
      return false;
    }
  }
}
