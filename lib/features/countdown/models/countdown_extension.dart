import 'package:flutter/material.dart';
import 'package:ngam_plan/features/countdown/models/countdown.dart';
import 'package:ngam_plan/src/localization/app_localizations.dart';

extension CountdownExtension on Countdown {
  List<int> toList() {
    return [year, month, day, hours, minutes, seconds];
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
}
