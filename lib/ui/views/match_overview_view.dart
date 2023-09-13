import 'package:breeze_case/ui/view_model/match_overview_view_model.dart';
import 'package:breeze_case/ui/widgets/match_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

final refreshControllerProvider =
    Provider((ref) => RefreshController(initialRefresh: true));

class MatchOverviewPage extends ConsumerWidget {
  const MatchOverviewPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(matchOverviewViewModelProvider);
    final refreshController = ref.watch(refreshControllerProvider);

    return Scaffold(
      body: SmartRefresher(
        controller: refreshController,
        onRefresh: () =>
            model.updateMatches(refreshController.refreshCompleted),
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 16),
          physics: const BouncingScrollPhysics(),
          itemCount: model.matchRepo.matches.length,
          itemBuilder: (context, index) => MatchCard(
            model.matchRepo.matches[index],
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            onPressed: () => model.navigateToMatch(index),
          ),
        ),
      ),
    );
  }
}
