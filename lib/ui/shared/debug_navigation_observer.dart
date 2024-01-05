import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

class DebugNavigationObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (kDebugMode) {
      debugPrint('Pushed route: ${route.settings.name}');
    }
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (kDebugMode) {
      debugPrint('Popped route: ${route.settings.name}');
    }
    super.didPop(route, previousRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (kDebugMode) {
      debugPrint('Removed route: ${route.settings.name}');
    }
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (kDebugMode) {
      debugPrint(
          'Replaced route: ${oldRoute?.settings.name} with ${newRoute?.settings.name}');
    }
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
}
