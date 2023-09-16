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

  Future<void> _showConfirmDialog(
    BuildContext context,
    void Function() onConfirm,
    String text,
  ) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(text),
        content: Text(text),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: const Text('Back'),
          ),
          TextButton(
            onPressed: () {
              onConfirm();
              Navigator.of(context).pop();
            },
            child: const Text('Confirm'),
          ),
        ],
        actionsAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(matchProgressControllerProvider(matchId));

    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        MatchCard(
          model.match,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        for (final phase in [
          _MatchPhase(
            title: 'You matched with ${model.match.otherUser.name}',
            date: model.match.createdAt,
            isUnlocked: true,
            isFirst: true,
          ),
          _MatchPhase(
            title: model.match.paidAt == null
                ? 'You pay for your date'
                : 'You paid for your date',
            date: model.match.paidAt,
            isActive: model.match.paidAt == null,
            isUnlocked: true,
            onPressed: model.match.paidAt == null ? model.payForDate : null,
          ),
          _MatchPhase(
            title: model.match.paidAt == null
                ? 'Date is picked'
                : model.match.plannedOn == null
                    ? 'Pick a date'
                    : 'You picked a date',
            date: model.match.availabilityGivenAt,
            isActive:
                model.match.paidAt != null && model.match.plannedOn == null,
            isUnlocked: model.match.paidAt != null,
            onPressed:
                model.match.paidAt != null && model.match.plannedOn == null
                    ? model.provideAvailabilityForDate
                    : null,
          ),
          _MatchPhase(
            title: model.match.plannedOn == null
                ? 'Waiting on location reveal'
                : model.match.confirmedAt == null
                    ? 'Confirm the date'
                    : 'The date is confirmed',
            date: model.match.confirmedAt != null
                ? DateTime(model.match.confirmedAt!)
                : null,
            isActive: model.match.plannedOn != null &&
                model.match.confirmedAt == null,
            isUnlocked: model.match.plannedOn != null,
            onPressed: model.match.plannedOn != null
                ? () => _showConfirmDialog(
                      context,
                      model.confirmPresenceForDate,
                      'Lorem ipsum dolar sit amet.',
                    )
                : null,
          ),
          _MatchPhase(
            title: model.match.plannedOn?.isAfter(DateTime.now()) == true
                ? 'You’re done!'
                : 'The day of the date',
            date: model.match.plannedOn,
            isUnlocked: model.match.confirmedAt != null,
            isLast: true,
          ),
        ])
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _MatchPhaseElement(phase),
          ),
      ]),
    );
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
            ? Text(
                phase.date!.toDateFormatted(),
                style: BreezeTheme.themeData.textTheme.bodySmall!.copyWith(
                  fontWeight:
                      phase.isUnlocked ? FontWeight.w700 : FontWeight.w400,
                ),
              )
            : null,
      ),
      Stack(alignment: Alignment.center, children: [
        Container(
          decoration: BoxDecoration(
            color: phase.isUnlocked ? kDarkBlue : kGreyColor,
            gradient: phase.isFirst
                ? const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, kDarkBlue],
                    stops: [0.5, 0.5],
                  )
                : phase.isLast
                    ? LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          phase.isUnlocked ? kDarkBlue : kGreyColor,
                          Colors.transparent,
                        ],
                        stops: const [0.5, 0.5],
                      )
                    : phase.isActive
                        ? const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [kDarkBlue, kGreyColor],
                            stops: [0.5, 0.5],
                          )
                        : null,
          ),
          width: 4,
          height: 60,
        ),
        Container(
          decoration: BoxDecoration(
            color: phase.isActive
                ? kPinkColor
                : !phase.isUnlocked
                    ? kGreyColor
                    : kDarkBlue,
            borderRadius: const BorderRadius.all(Radius.circular(9)),
          ),
          width: 18,
          height: 18,
        ),
      ]),
      const SizedBox(width: 9),
      Flexible(
        child: phase.isActive && phase.onPressed != null
            ? MaterialButton(
                onPressed: phase.onPressed,
                color: kPinkColor,
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Text(
                  phase.title,
                  style: BreezeTheme.themeData.textTheme.bodyMedium!.copyWith(
                    color: kWhiteColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            : Text(
                phase.title,
                style: BreezeTheme.themeData.textTheme.bodyMedium!.copyWith(
                  color: phase.isUnlocked || phase.isActive
                      ? kDarkBlue
                      : kGreyColor,
                  fontSize: 18,
                  fontWeight: phase.isUnlocked || phase.isActive
                      ? FontWeight.w700
                      : FontWeight.w400,
                ),
              ),
      ),
    ]);
  }
}

class _MatchPhase {
  const _MatchPhase({
    required this.title,
    this.date,
    this.isActive = false,
    this.isUnlocked = false,
    this.isFirst = false,
    this.isLast = false,
    this.onPressed,
  });

  final String title;
  final DateTime? date;
  final bool isActive;
  final bool isUnlocked;
  final bool isFirst;
  final bool isLast;
  final void Function()? onPressed;
}
