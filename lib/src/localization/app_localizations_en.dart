// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Ngam plan';

  @override
  String get eventsSectionTitle => 'Events';

  @override
  String get homeSectionTitle => 'Home';

  @override
  String get settingsSectionTitle => 'Settings';

  @override
  String get upcomingEventsTitle => 'Upcoming Events';

  @override
  String get noUpcomingEvents => 'No upcoming events.';

  @override
  String get thisMonthsEventsTitle => 'This month\'s Events';

  @override
  String item(int index) {
    return 'Item $index';
  }

  @override
  String daysAgo(int days) {
    return '$days days ago';
  }

  @override
  String inDays(int days) {
    return 'in $days days';
  }

  @override
  String yearAnniversary(int years) {
    return '$years-year anniversary';
  }

  @override
  String dayAnniversary(int days) {
    return '$days-day anniversary';
  }
}
