import 'package:breeze_case/core/constants/icons.dart';
import 'package:breeze_case/core/extensions/datetime.dart';
import 'package:breeze_case/core/models/match.dart';
import 'package:breeze_case/ui/shared/build_context_ext.dart';
import 'package:breeze_case/ui/shared/colors.dart';
import 'package:breeze_case/ui/shared/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MatchCard extends StatelessWidget {
  const MatchCard(this.match,
      {this.onPressed,
      this.padding,
      this.imagePadding = const EdgeInsets.all(12),
      this.borderRadius = const BorderRadius.all(Radius.circular(25)),
      Key? key})
      : super(key: key);

  final Match match;

  final void Function()? onPressed;

  final EdgeInsetsGeometry? padding;

  final EdgeInsetsGeometry imagePadding;

  final BorderRadiusGeometry borderRadius;

  @override
  Widget build(BuildContext context) {
    final List<_DateDetailData> itemsForDate = [
      if (match.deal != null) _DateDetailData(match.plannedOn!.toDateFormatOrTodayTomorrow(), AppIcons.calendar),
      _DateDetailData(match.deal != null ? match.deal! : match.city, AppIcons.location),
      _DateDetailData(match.dealType, AppIcons.walkAndTalk),
    ];

    return GestureDetector(
        onTap: onPressed,
        child: Container(
            margin: padding,
            decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: borderRadius,
                boxShadow: const [BoxShadow(color: kGreyColor, blurRadius: 3)]),
            child: Container(
                height: 200,
                width: context.screenWidth,
                padding: imagePadding,
                child: Row(children: [
                  CachedNetworkImage(
                      imageUrl: match.otherUser.photo,
                      errorWidget: (_, __, ___) => const SizedBox(width: 100, height: 100, child: Icon(Icons.error)),
                      imageBuilder: (_, imageProvider) => Container(
                          width: 134,
                          height: 176,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: const BorderRadius.all(Radius.circular(12)),
                              image: DecorationImage(image: imageProvider, fit: BoxFit.cover)))),
                  const SizedBox(width: 20),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Date details', style: BreezeTheme.themeData.textTheme.titleSmall),
                        const SizedBox(height: 10),
                        for (final info in itemsForDate)
                          _DateDetailItem(info,
                              width: context.screenWidth -
                                  (padding?.horizontal ?? 0) -
                                  imagePadding.horizontal -
                                  134 -
                                  20),
                      ])
                ]))));
  }
}

class _DateDetailItem extends StatelessWidget {
  const _DateDetailItem(this.data, {required this.width, Key? key}) : super(key: key);

  final _DateDetailData data;

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(children: [
        Container(width: 21, alignment: Alignment.center, child: SvgPicture.asset(data.icon, width: 21, height: 21)),
        const SizedBox(width: 10),
        Flexible(child: Text(data.title)),
      ]),
    );
  }
}

class _DateDetailData {
  const _DateDetailData(this.title, this.icon);

  final String title;
  final String icon;
}
