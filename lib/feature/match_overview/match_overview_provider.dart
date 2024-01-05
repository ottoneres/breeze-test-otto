import 'package:breeze_case/feature/match_overview/match_overview_notifier.dart';
import 'package:breeze_case/feature/match_overview/match_overview_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers/providers.dart';

final matchOverviewProvider =
    StateNotifierProvider<MatchOverviewNotifier, MatchOverviewState>((ref) {
  final matchRepo = ref.read(matchRepoProvider);
  final navigationService = ref.read(navigationProvider);
  return MatchOverviewNotifier(matchRepo, navigationService);
});
