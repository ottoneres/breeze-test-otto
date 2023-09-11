import 'package:breeze_case/core/services/navigation_service.dart';
import 'package:breeze_case/core/providers/providers.dart';
import 'package:breeze_case/core/repositories/match_repo.dart';
import 'package:flutter/foundation.dart' show ChangeNotifier, debugPrint;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final matchOverviewViewModelProvider = Provider((ref) {
  final matchRepo = ref.watch(matchRepoProvider);
  final navigationService = ref.read(navigationProvider);
  return MatchOverviewViewModel(matchRepo, navigationService);
});

class MatchOverviewViewModel extends ChangeNotifier {
  final MatchRepository matchRepo;
  final NavigationService navigationService;

  MatchOverviewViewModel(this.matchRepo, this.navigationService);

  Future<void> updateMatches(final void Function() onRefreshCompleted) async {
    final bool success = await matchRepo.getMatches();
    if (!success) debugPrint('Error while updating matches');
    onRefreshCompleted();
    notifyListeners();
  }

  void navigateToMatch(int index) => navigationService.push('/match/${matchRepo.matches[index].id}');
}
