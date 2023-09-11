import 'package:breeze_case/core/api/api.dart';
import 'package:breeze_case/core/navigation_service.dart';
import 'package:breeze_case/core/repositories/match_repo.dart';
import 'package:breeze_case/core/router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiProvider = Provider((ref) => Api());

final matchRepoProvider = Provider((ref) {
  final api = ref.watch(apiProvider);
  return MatchRepository(api: api);
});

final navigationProvider = Provider<NavigationService>((ref) {
  final goRouter = ref.read(routerProvider);
  return NavigationService(goRouter);
});
