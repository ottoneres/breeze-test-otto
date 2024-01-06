import 'package:go_router/go_router.dart';
import 'package:breeze_case/core/models/match.dart';

class NavigationService {
  const NavigationService(this.goRouter);

  final GoRouter goRouter;

  void push(String routeName) => goRouter.push(routeName);

  void pop() => goRouter.pop();

  // decouples navigation from the match list
  void navigateToMatch(Match match) => push('/match/${match.id}');
}
