import 'package:flutter/material.dart';
import 'package:ngam_plan/src/localization/app_localizations.dart';

extension DurationExtension on Duration {
  int get months => (inDays % 365) ~/ 30;
  int get years => inDays ~/ 365;
  int get days => (inDays % 365) % 30;
  int get hours => inHours.remainder(24);
  int get minutes => inMinutes.remainder(60);
  int get seconds => inSeconds.remainder(60);

  List<({int value, String label})> toValueAndLabelist(BuildContext context) {
    return [
      (value: years, label: AppLocalizations.of(context)!.year),
      (value: months, label: AppLocalizations.of(context)!.month),
      (value: days, label: AppLocalizations.of(context)!.day),
      (value: hours, label: AppLocalizations.of(context)!.hour),
      (value: minutes, label: AppLocalizations.of(context)!.minute),
      (value: seconds, label: AppLocalizations.of(context)!.second),
    ];
  }

  List<({int value, String label})> filteredValueAndLabelist(BuildContext context) {
    // 1. Create the list only once to improve performance.
    final fullList = toValueAndLabelist(context);

    // 2. Find the index of the first non-zero time unit.
    //    Using `indexWhere` is safer and more direct than `firstWhere` + `indexOf`.
    int startIndex = fullList.indexWhere((element) => element.value != 0);

    // 3. If all values are zero, default to showing hours, minutes, and seconds.
    if (startIndex == -1) {
      startIndex = 4;
    }

    // 4. Enforce the rule that the start index can't be more than 3.
    //    This ensures we always show at least hours, minutes, and seconds.
    //    The index for 'hours' is 3.
    if (startIndex > 3) {
      startIndex = 4;
    }

    // 5. Calculate the end index to get a slice of 3 items.
    final endIndex = startIndex + 3;

    // 6. Return the sublist, ensuring the end index doesn't go out of bounds.
    return fullList.sublist(startIndex, endIndex > fullList.length ? fullList.length : endIndex);
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
