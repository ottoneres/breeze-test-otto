import 'package:breeze_case/core/extensions/datetime.dart';
import 'package:breeze_case/ui/shared/colors.dart';
import 'package:breeze_case/ui/shared/theme.dart';
import 'package:breeze_case/ui/view_model/match_progress_view_model.dart';
import 'package:breeze_case/ui/widgets/match_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MatchProgressPage extends ConsumerWidget {
  const MatchProgressPage({required this.matchId, super.key});

  final String matchId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(matchProgressControllerProvider(matchId));

    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        MatchCard(model.match,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25))),
        for (final phase in [
          _MatchPhase(
              date: model.match.createdAt,
              title: 'You matched with ${model.match.otherUser.name}',
              isFirst: true,
              isUnlocked: true),
          _MatchPhase(
              date: model.match.paidAt,
              title: model.match.paidAt == null
                  ? 'You pay for your date'
                  : 'You paid for your date',
              isUnlocked: true,
              isActive: model.match.paidAt == null,
              onPressed: model.match.paidAt == null ? model.payForDate : null),
          _MatchPhase(
              date: model.match.availabilityGivenAt,
              title: model.match.paidAt == null
                  ? 'Date is picked'
                  : model.match.plannedOn == null
                      ? 'Pick a date'
                      : 'You picked a date',
              isUnlocked: model.match.paidAt != null,
              isActive:
                  model.match.paidAt != null && model.match.plannedOn == null,
              onPressed:
                  model.match.paidAt != null && model.match.plannedOn == null
                      ? model.provideAvailabilityForDate
                      : null),
          _MatchPhase(
              date: model.match.confirmedAt != null
                  ? DateTime(model.match.confirmedAt!)
                  : null,
              title: model.match.plannedOn == null
                  ? 'Waiting on location reveal'
                  : model.match.confirmedAt == null
                      ? 'Confirm the date'
                      : 'The date is confirmed',
              isUnlocked: model.match.plannedOn != null,
              onPressed: model.match.plannedOn != null
                  ? () => _showConfirmDialog(
                      context,
                      model.confirmPresenceForDate,
                      'Lorem ipsum dolar sit amet.')
                  : null,
              isActive: model.match.plannedOn != null &&
                  model.match.confirmedAt == null),
          _MatchPhase(
              date: model.match.plannedOn,
              title: model.match.plannedOn?.isAfter(DateTime.now()) == true
                  ? 'You’re done!'
                  : 'The day of the date',
              isLast: true,
              isUnlocked: model.match.confirmedAt != null)
        ])
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _MatchPhaseElement(phase)),
      ]),
    );
  }

  Future<void> _showConfirmDialog(
      BuildContext context, void Function() onConfirm, String text) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
                title: Text(text),
                content: Text(text),
                actionsAlignment: MainAxisAlignment.spaceBetween,
                actions: [
                  TextButton(
                      onPressed: Navigator.of(context).pop,
                      child: const Text('Back')),
                  TextButton(
                      onPressed: () {
                        onConfirm();
                        Navigator.of(context).pop();
                      },
                      child: const Text('Confirm'))
                ]));
  }
}

class _MatchPhaseElement extends StatelessWidget {
  const _MatchPhaseElement(this.phase, {Key? key}) : super(key: key);

  final _MatchPhase phase;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
          alignment: Alignment.center,
          width: 60,
          child: phase.date != null
              ? Text(phase.date!.toDateFormatted(),
                  style: BreezeTheme.themeData.textTheme.bodySmall!.copyWith(
                      fontWeight:
                          phase.isUnlocked ? FontWeight.w700 : FontWeight.w400))
              : null),
      Stack(alignment: Alignment.center, children: [
        Container(
            width: 4,
            height: 60,
            decoration: BoxDecoration(
                color: phase.isUnlocked ? kDarkBlue : kGreyColor,
                gradient: phase.isFirst
                    ? const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, kDarkBlue],
                        stops: [.5, .5])
                    : phase.isLast
                        ? LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                                phase.isUnlocked ? kDarkBlue : kGreyColor,
                                Colors.transparent
                              ],
                            stops: const [
                                .5,
                                .5
                              ])
                        : phase.isActive
                            ? const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [kDarkBlue, kGreyColor],
                                stops: [.5, .5])
                            : null)),
        Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
                color: phase.isActive
                    ? kPinkColor
                    : !phase.isUnlocked
                        ? kGreyColor
                        : kDarkBlue,
                borderRadius: BorderRadius.circular(9))),
      ]),
      const SizedBox(width: 9),
      Flexible(
          child: phase.isActive && phase.onPressed != null
              ? MaterialButton(
                  onPressed: phase.onPressed,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  color: kPinkColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Text(phase.title,
                      style: BreezeTheme.themeData.textTheme.bodyMedium!
                          .copyWith(
                              fontSize: 18,
                              color: kWhiteColor,
                              fontWeight: FontWeight.w700)))
              : Text(phase.title,
                  style: BreezeTheme.themeData.textTheme.bodyMedium!.copyWith(
                      fontSize: 18,
                      color: phase.isUnlocked || phase.isActive
                          ? kDarkBlue
                          : kGreyColor,
                      fontWeight: phase.isUnlocked || phase.isActive
                          ? FontWeight.w700
                          : FontWeight.w400))),
    ]);
  }
}

class _MatchPhase {
  const _MatchPhase(
      {required this.title,
      this.date,
      this.isActive = false,
      this.isUnlocked = false,
      this.isFirst = false,
      this.isLast = false,
      this.onPressed});

  final String title;
  final DateTime? date;
  final bool isActive;
  final bool isUnlocked;
  final bool isFirst;
  final bool isLast;
  final void Function()? onPressed;
}
