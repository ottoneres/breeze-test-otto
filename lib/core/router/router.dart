import 'package:breeze_case/ui/views/match_overview_view.dart';
import 'package:breeze_case/ui/views/match_progress_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/foundation.dart';

SlideTransition _slideFromBottomTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  return SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(0, 1), // Start from bottom
      end: Offset.zero, // End at center
    ).animate(animation),
    child: child,
  );
}

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
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey, // Ensures unique key for the page
          child: MatchProgressPage(matchId: state.pathParameters['matchId']!),
          transitionsBuilder: _slideFromBottomTransition,
          transitionDuration: const Duration(milliseconds: 100),
        ),
      ),
    ],
    initialLocation: '/matches',
    redirect: (context, state) {
      debugRouteListener(state);
      return null; // No redirection, continue to the intended route
    },
  ),
);

void debugRouteListener(GoRouterState state) {
  if (kDebugMode) {
    print('Routing to: ${state.matchedLocation}');
  }
}
