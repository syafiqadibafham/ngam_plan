import 'package:flutter/material.dart';
import 'package:ngam_plan/features/events/models/event.dart';
import 'package:ngam_plan/features/events/models/event_types.dart';
import 'package:ngam_plan/src/localization/app_localizations.dart';

class CountdownCalculator {
  static String getCountdownString(Event event, BuildContext context) {
    final now = DateTime.now();

    switch (event.type) {
      case EventType.anniversary:
        return _getAnniversaryCountdown(event, now, context);
      case EventType.memory:
        return _getMemoryCountdown(event, now, context);
      default:
        return _getAnnualCountdown(event, now, context);
    }
  }

  static DateTime getNextMilestoneDate(Event event) {
    final now = DateTime.now();
    switch (event.type) {
      case EventType.anniversary:
        final nextAnnualDate = _getNextAnnualAnniversaryDate(event, now);
        final next100DayDate = _getNext100DayAnniversaryDate(event, now);
        return nextAnnualDate.isBefore(next100DayDate)
            ? nextAnnualDate
            : next100DayDate;
      case EventType.memory:
        return event.date;
      default:
        return _getAnnualOccurrenceDate(event, now);
    }
  }

  static String _getMemoryCountdown(
      Event event, DateTime now, BuildContext context) {
    final difference = event.date.difference(now);
    if (difference.isNegative) {
      return AppLocalizations.of(context)!.daysAgo(-difference.inDays);
    }
    return AppLocalizations.of(context)!.inDays(difference.inDays);
  }

  static String _getAnnualCountdown(
      Event event, DateTime now, BuildContext context) {
    final nextOccurrence = _getAnnualOccurrenceDate(event, now);
    final difference = nextOccurrence.difference(now);
    return AppLocalizations.of(context)!.inDays(difference.inDays);
  }

  static String _getAnniversaryCountdown(
      Event event, DateTime now, BuildContext context) {
    final nextAnnualDate = _getNextAnnualAnniversaryDate(event, now);
    final next100DayDate = _getNext100DayAnniversaryDate(event, now);

    DateTime nextMilestoneDate;
    String milestoneLabel;

    if (nextAnnualDate.isBefore(next100DayDate)) {
      nextMilestoneDate = nextAnnualDate;
      final yearsPassed = nextAnnualDate.year - event.date.year;
      milestoneLabel = AppLocalizations.of(context)!.yearAnniversary(yearsPassed);
    } else {
      nextMilestoneDate = next100DayDate;
      final daysPassed = nextMilestoneDate.difference(event.date).inDays;
      milestoneLabel = AppLocalizations.of(context)!.dayAnniversary(daysPassed);
    }

    final difference = nextMilestoneDate.difference(now);
    return '$milestoneLabel ${AppLocalizations.of(context)!.inDays(difference.inDays)}';
  }

  static DateTime _getAnnualOccurrenceDate(Event event, DateTime now) {
    final eventDate = event.date;
    DateTime nextOccurrence = DateTime(now.year, eventDate.month, eventDate.day);

    if (nextOccurrence.isBefore(now)) {
      nextOccurrence = DateTime(now.year + 1, eventDate.month, eventDate.day);
    }
    return nextOccurrence;
  }

  static DateTime _getNextAnnualAnniversaryDate(Event event, DateTime now) {
    final anniversaryStartDate = event.date;
    int yearsPassed = now.year - anniversaryStartDate.year;

    DateTime nextAnniversary = DateTime(anniversaryStartDate.year + yearsPassed,
        anniversaryStartDate.month, anniversaryStartDate.day);

    if (nextAnniversary.isBefore(now)) {
      yearsPassed++;
      nextAnniversary = DateTime(anniversaryStartDate.year + yearsPassed,
          anniversaryStartDate.month, anniversaryStartDate.day);
    }
    return nextAnniversary;
  }

  static DateTime _getNext100DayAnniversaryDate(Event event, DateTime now) {
    final daysSince = now.difference(event.date).inDays;
    if (daysSince < 0) {
      return event.date.add(const Duration(days: 100));
    }

    final next100DayMilestone = ((daysSince / 100).floor() + 1) * 100;
    return event.date.add(Duration(days: next100DayMilestone));
  }
}
