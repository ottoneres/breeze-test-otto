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
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemBuilder: (context, index) => MatchCard(
            model.matchRepo.matches[index],
            onPressed: () => model.navigateToMatch(index),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          ),
          itemCount: model.matchRepo.matches.length,
        ),
      ),
    );
  }
}
