import 'package:flutter/material.dart';
import 'package:ngam_plan/src/localization/app_localizations.dart';

extension DurationExtension on Duration {
  int get months => inDays ~/ 30;
  int get years => months ~/ 12;
  int get days => inDays;
  int get hours => inHours.remainder(24);
  int get minutes => inMinutes.remainder(60);
  int get seconds => inSeconds.remainder(60);

  List<int> toList() {
    return [years, months, days, hours, minutes, seconds];
  }

  List<String> labels(BuildContext context) {
    return [
      AppLocalizations.of(context)!.year,
      AppLocalizations.of(context)!.month,
      AppLocalizations.of(context)!.day,
      AppLocalizations.of(context)!.hour,
      AppLocalizations.of(context)!.minute,
      AppLocalizations.of(context)!.second,
    ];
  }

  List<String> dateLabels(BuildContext context) {
    return [
      AppLocalizations.of(context)!.year,
      AppLocalizations.of(context)!.month,
      AppLocalizations.of(context)!.day,
    ];
  }

  List<String> timeLabels(BuildContext context) {
    return [
      AppLocalizations.of(context)!.hour,
      AppLocalizations.of(context)!.minute,
      AppLocalizations.of(context)!.second,
    ];
  }
}
