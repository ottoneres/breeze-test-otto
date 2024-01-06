import 'package:breeze_case/core/api/api_response.dart';
import 'package:breeze_case/core/constants/api_routes.dart';
import 'package:breeze_case/core/models/match.dart';
import 'package:breeze_case/core/api/api.dart';

class MatchRepository {
  MatchRepository({required this.api});
  // Reduce the scope of the repository from taking care of state and updating the list
  // to only taking care of the API calls

  final Api api;

  /// Updates the [matches] list with the latest matches from the [Api]. When unsuccessful, it will return `false`.
  Future<List<Match>> getMatches() async {
    try {
      final ApiResponse response = await api.get(ApiRoutes.matches);
      if (!response.isSuccessful) return [];
      final List<Match> matches = Match.fromList((response.data));
      return matches;
    } catch (e) {
      return [];
    }
  }

  Future<bool> payForMatchById(String matchId) async {
    try {
      final ApiResponse response =
          await api.get(ApiRoutes.paymentForMatch(matchId));
      return response.isSuccessful;
    } catch (e) {
      return false;
    }
  }

  Future<bool> setAvailabilityGivenForMatchById(String matchId) async {
    try {
      final ApiResponse response =
          await api.post(ApiRoutes.availabilityForMatch(matchId), {});
      return response.isSuccessful;
    } catch (e) {
      return false;
    }
  }

  Future<bool> setConfirmedAtForMatchById(String matchId) async {
    try {
      final ApiResponse response =
          await api.put(ApiRoutes.confirmPresenceForMatch(matchId), {});
      return response.isSuccessful;
    } catch (e) {
      return false;
    }
  }
}
