import 'package:breeze_case/core/api/api.dart';
import 'package:breeze_case/core/services/navigation_service.dart';
import 'package:breeze_case/core/repositories/match_repo.dart';
import 'package:breeze_case/core/router/router.dart';
import 'package:breeze_case/feature/match/match_list_state_notifier.dart';
import 'package:breeze_case/feature/match/match_state_notifier.dart';
import 'package:breeze_case/core/models/match.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiProvider = Provider((ref) => Api());

final matchRepoProvider = Provider((ref) {
  final api = ref.watch(apiProvider);
  return MatchRepository(api: api);
});

final navigationProvider = Provider<NavigationService>((ref) {
  final goRouter = ref.read(routerProvider);
  return NavigationService(goRouter);
});

// Provider that takes care of actions regarding the match list
final matchListProvider = StateNotifierProvider<MatchListNotifier, List<Match>>(
  (ref) {
    final matchRepo = ref.watch(matchRepoProvider);
    return MatchListNotifier(matchRepo);
  },
);

// Provider that takes care of actions regarding a single match
final matchProgressProvider =
    StateNotifierProvider.family<MatchNotifier, MatchProgressState, String>(
  (ref, matchId) {
    final matchRepo = ref.watch(matchRepoProvider);
    return MatchNotifier(ref, matchRepo, matchId);
  },
);

// this provider returns the current match from the matchListProvider
// it's decoupled to facilitate synchronizing with the list and navigating to a match from the list
// and to decouple business logic from the UI from calling a method such as ".retrieveMatchById" or similar
final currentMatchProvider = Provider.family<Match, String>((ref, matchId) {
  final matchListState = ref.watch(matchListProvider);
  return matchListState.firstWhere(
    (match) => match.id == matchId,
    orElse: () => throw Exception('Match not found'),
  );
});
