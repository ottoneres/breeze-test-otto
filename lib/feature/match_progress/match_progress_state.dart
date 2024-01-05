import 'package:breeze_case/core/models/match.dart';

class MatchProgressState {
  final Match match;
  final bool isBusy;

  MatchProgressState({required this.match, this.isBusy = false});
}
