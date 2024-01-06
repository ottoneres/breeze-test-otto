import 'package:breeze_case/core/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:breeze_case/core/repositories/match_repo.dart';

class MatchProgressState {
  final bool isBusy;

  MatchProgressState({this.isBusy = false});
}

class MatchNotifier extends StateNotifier<MatchProgressState> {
  final MatchRepository matchRepo;
  final String matchId;
  final StateNotifierProviderRef ref;

  MatchNotifier(this.ref, this.matchRepo, this.matchId)
      : super(MatchProgressState());

  bool isBusy = false;

  Future<void> payForDate() async {
    if (isBusy) return;
    _setBusy(true);
    final succcess = await matchRepo.payForMatchById(matchId);
    if (succcess) {
      ref.read(matchListProvider.notifier).updateMatches();
    }
    _setBusy(false);
  }

  Future<void> provideAvailabilityForDate() async {
    if (isBusy) return;
    _setBusy(true);
    final success = await matchRepo.setAvailabilityGivenForMatchById(matchId);
    if (success) {
      ref.read(matchListProvider.notifier).updateMatches();
    }
    _setBusy(false);
  }

  Future<void> confirmPresenceForDate() async {
    if (isBusy) return;
    _setBusy(true);
    final success = await matchRepo.setConfirmedAtForMatchById(matchId);
    if (success) {
      ref.read(matchListProvider.notifier).updateMatches();
    }
    _setBusy(false);
  }

  void _setBusy(bool value) {
    state = MatchProgressState(isBusy: value);
  }
}
