import 'package:breeze_case/core/repositories/match_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:breeze_case/core/models/match.dart';
import 'match_progress_state.dart';

class MatchProgressController extends StateNotifier<MatchProgressState> {
  final MatchRepository matchRepo;

  MatchProgressController(this.matchRepo, Match match)
      : super(MatchProgressState(match: match));

  void _setBusy(bool value) {
    state = MatchProgressState(match: state.match, isBusy: value);
  }

  bool isBusy = false;
  Future<void> payForDate() async {
    if (isBusy) return;
    _setBusy(true);
    await matchRepo.payForMatchById(state.match.id);
    _setBusy(false);
  }

  Future<void> provideAvailabilityForDate() async {
    if (isBusy) return;
    _setBusy(true);
    await matchRepo.setAvailabilityGivenForMatchById(state.match.id);
    _setBusy(false);
  }

  Future<void> confirmPresenceForDate() async {
    if (isBusy) return;
    _setBusy(true);
    await matchRepo.setConfirmedAtForMatchById(state.match.id);
    _setBusy(false);
  }
}
