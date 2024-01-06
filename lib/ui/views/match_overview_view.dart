import 'package:breeze_case/core/providers/providers.dart';
import 'package:breeze_case/ui/shared/colors.dart';
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
    final state = ref.watch(matchListProvider);
    final matchNotifier = ref.read(matchListProvider.notifier);
    final navigation = ref.read(navigationProvider);
    final refreshController = ref.watch(refreshControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: SmartRefresher(
          controller: refreshController,
          onRefresh: () async {
            matchNotifier.updateMatches();
            refreshController.refreshCompleted();
          },
          header: const MaterialClassicHeader(color: kBlueColor),
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemBuilder: (context, index) => MatchCard(
              state[index],
              onPressed: () => navigation.navigateToMatch(state[index]),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            ),
            itemCount: state.length,
          ),
        ),
      ),
    );
  }
}
