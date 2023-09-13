import 'package:breeze_case/ui/views/match_overview_view.dart';
import 'package:breeze_case/ui/views/match_progress_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider(
  (ref) => GoRouter(
    routes: [
      GoRoute(
        path: '/matches',
        pageBuilder: (context, state) => const MaterialPage(
          child: MatchOverviewPage(),
        ),
      ),
      GoRoute(
        path: '/match/:matchId',
        pageBuilder: (context, state) => MaterialPage(
          child: MatchProgressPage(matchId: state.pathParameters['matchId']!),
        ),
      ),
    ],
    initialLocation: '/matches',
  ),
);
