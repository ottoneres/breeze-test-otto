import 'package:breeze_case/core/repositories/match_repo.dart';
import 'package:breeze_case/core/services/navigation_service.dart';
import 'package:breeze_case/feature/match_overview/match_overview_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:breeze_case/core/models/match.dart';
import 'package:flutter/foundation.dart' show debugPrint;

class MatchOverviewNotifier extends StateNotifier<MatchOverviewState> {
  final MatchRepository matchRepo;
  final NavigationService navigationService;

  MatchOverviewNotifier(this.matchRepo, this.navigationService)
      : super(MatchOverviewState());
  Future<void> updateMatches() async {
    final matches = await matchRepo.getMatches();
    if (matches == true) {
      sortMatches(matchRepo.matches);
      state = MatchOverviewState(matches: matchRepo.matches);
    } else {
      debugPrint('Error while updating matches');
    }
  }

  void navigateToMatch(int index) {
    navigationService.push('/match/${state.matches[index].id}');
  }

  void sortMatches(List<Match> matches) {
    matches.sort((a, b) {
      final now = DateTime.now();
      final aUpcoming = a.plannedOn != null && a.plannedOn!.isAfter(now);
      final bUpcoming = b.plannedOn != null && b.plannedOn!.isAfter(now);

      if (aUpcoming && bUpcoming) {
        // Both are upcoming: sort by soonest date
        return a.plannedOn!.compareTo(b.plannedOn!);
      } else if (aUpcoming) {
        return -1; // A is upcoming, B is not
      } else if (bUpcoming) {
        return 1; // B is upcoming, A is not
      } else {
        // Neither are upcoming, check if they are past dates
        final aPast = a.plannedOn != null && a.plannedOn!.isBefore(now);
        final bPast = b.plannedOn != null && b.plannedOn!.isBefore(now);
        if (aPast && bPast) {
          // Both are past: sort by most recent date
          return b.plannedOn!.compareTo(a.plannedOn!);
        } else {
          // Sort by creation date if both are not past dates
          return b.createdAt.compareTo(a.createdAt);
        }
      }
    });
  }
}
