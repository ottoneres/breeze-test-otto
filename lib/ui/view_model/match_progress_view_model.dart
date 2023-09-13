import 'package:breeze_case/core/models/match.dart';
import 'package:breeze_case/core/providers/providers.dart';
import 'package:breeze_case/core/repositories/match_repo.dart';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final matchProgressControllerProvider = ChangeNotifierProvider.autoDispose
    .family<MatchProgressController, String>((ref, matchId) {
  final matchRepo = ref.watch(matchRepoProvider);
  final Match match =
      matchRepo.matches.firstWhereOrNull((match) => match.id == matchId)!;
  return MatchProgressController(matchRepo, match);
});

class MatchProgressController extends ChangeNotifier {
  MatchProgressController(this.matchRepo, this.match);

  final MatchRepository matchRepo;

  final Match match;

  bool isBusy = false;
  bool _disposed = false;

  Future<void> payForDate() async {
    if (isBusy) return;
    setBusy(true);
    await matchRepo.payForMatchById(match.id);
    setBusy(false);
  }

  Future<void> provideAvailabilityForDate() async {
    if (isBusy) return;
    setBusy(true);
    await matchRepo.setAvailabilityGivenForMatchById(match.id);
    setBusy(false);
  }

  Future<void> confirmPresenceForDate() async {
    if (isBusy) return;
    setBusy(true);
    await matchRepo.setConfirmedAtForMatchById(match.id);
    setBusy(false);
  }

  void setBusy(bool value) {
    isBusy = value;
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
