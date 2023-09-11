import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  /// Returns the [MediaQueryData] using the [MediaQuery] of the [BuildContext].
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Returns the width of the screen using the [MediaQuery] of the [BuildContext].
  double get screenWidth => mediaQuery.size.width;
}
