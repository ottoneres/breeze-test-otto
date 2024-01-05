import 'package:breeze_case/core/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:breeze_case/core/models/match.dart';
import 'package:collection/collection.dart' show IterableExtension;
import 'match_progress_state.dart';
import 'match_progress_notifier.dart';

final matchProgressControllerProvider = StateNotifierProvider.autoDispose
    .family<MatchProgressController, MatchProgressState, String>(
        (ref, matchId) {
  final matchRepo = ref.watch(matchRepoProvider);
  final Match match =
      matchRepo.matches.firstWhereOrNull((match) => match.id == matchId)!;
  return MatchProgressController(matchRepo, match);
});
