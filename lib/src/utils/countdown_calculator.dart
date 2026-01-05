import 'package:flutter/material.dart';
import 'package:ngam_plan/features/countdown/models/countdown.dart';
import 'package:ngam_plan/features/events/models/event.dart';
import 'package:ngam_plan/features/events/models/calculation_types.dart';
import 'package:ngam_plan/src/localization/app_localizations.dart';

class CountdownCalculator {
  static CountdownResult getCountdown(Event event, BuildContext context) {
    final now = DateTime.now();

    switch (event.calculationType) {
      case CalculationType.anniversary:
        return _calculateAnniversaryCountdown(event, now, context);
      case CalculationType.memory:
        return _calculateMemoryCountdown(event, now);
      default:
        return _calculateAnnualCountdown(event, now, context);
    }
  }

  static String getCountdownString(Event event, BuildContext context) {
    final countdown = getCountdown(event, context);
    final days = countdown.duration.inDays;
    if (countdown.duration.isNegative) {
      return AppLocalizations.of(context)!.daysAgo(-days);
    }
    return '${countdown.milestoneLabel} ${AppLocalizations.of(context)!.inDays(days)}';
  }

  static DateTime getNextMilestoneDate(Event event) {
    final now = DateTime.now();
    switch (event.calculationType) {
      case CalculationType.anniversary:
        final nextAnnualDate = _getNextAnnualAnniversaryDate(event, now);
        final next100DayDate = _getNext100DayAnniversaryDate(event, now);
        return nextAnnualDate.isBefore(next100DayDate) ? nextAnnualDate : next100DayDate;
      case CalculationType.memory:
        return event.startDate;
      default:
        return _getAnnualOccurrenceDate(event, now);
    }
  }

  static CountdownResult _calculateMemoryCountdown(Event event, DateTime now) {
    return CountdownResult(
      milestoneLabel: event.name,
      duration: event.startDate.difference(now),
    );
  }

  static CountdownResult _calculateAnnualCountdown(Event event, DateTime now, BuildContext context) {
    final nextOccurrence = _getAnnualOccurrenceDate(event, now);
    final difference = nextOccurrence.difference(now);
    return CountdownResult(milestoneLabel: event.name, duration: difference);
  }

  static CountdownResult _calculateAnniversaryCountdown(Event event, DateTime now, BuildContext context) {
    final nextAnnualDate = _getNextAnnualAnniversaryDate(event, now);
    final next100DayDate = _getNext100DayAnniversaryDate(event, now);

    DateTime nextMilestoneDate;
    String milestoneLabel;

    if (nextAnnualDate.isBefore(next100DayDate)) {
      nextMilestoneDate = nextAnnualDate;
      final yearsPassed = nextAnnualDate.year - event.startDate.year;
      milestoneLabel = AppLocalizations.of(context)!.yearAnniversary(yearsPassed);
    } else {
      nextMilestoneDate = next100DayDate;
      final daysPassed = nextMilestoneDate.difference(event.startDate).inDays;
      milestoneLabel = AppLocalizations.of(context)!.dayAnniversary(daysPassed);
    }

    final difference = nextMilestoneDate.difference(now);
    return CountdownResult(milestoneLabel: milestoneLabel, duration: difference);
  }

  static DateTime _getAnnualOccurrenceDate(Event event, DateTime now) {
    final eventDate = event.startDate;
    DateTime nextOccurrence = DateTime(now.year, eventDate.month, eventDate.day);

    if (nextOccurrence.isBefore(now)) {
      nextOccurrence = DateTime(now.year + 1, eventDate.month, eventDate.day);
    }
    return nextOccurrence;
  }

  static DateTime _getNextAnnualAnniversaryDate(Event event, DateTime now) {
    final anniversaryStartDate = event.startDate;
    int yearsPassed = now.year - anniversaryStartDate.year;

    DateTime nextAnniversary = DateTime(anniversaryStartDate.year + yearsPassed, anniversaryStartDate.month, anniversaryStartDate.day);

    if (nextAnniversary.isBefore(now)) {
      yearsPassed++;
      nextAnniversary = DateTime(anniversaryStartDate.year + yearsPassed, anniversaryStartDate.month, anniversaryStartDate.day);
    }
    return nextAnniversary;
  }

  static DateTime _getNext100DayAnniversaryDate(Event event, DateTime now) {
    final daysSince = now.difference(event.startDate).inDays;
    if (daysSince < 0) {
      return event.startDate.add(const Duration(days: 100));
    }

    final next100DayMilestone = ((daysSince / 100).floor() + 1) * 100;
    return event.startDate.add(Duration(days: next100DayMilestone));
  }
}
