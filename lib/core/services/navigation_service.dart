import 'package:go_router/go_router.dart';

class NavigationService {
  const NavigationService(this.goRouter);

  final GoRouter goRouter;

  void push(String routeName) => goRouter.push(routeName);

  void pop() => goRouter.pop();
}
