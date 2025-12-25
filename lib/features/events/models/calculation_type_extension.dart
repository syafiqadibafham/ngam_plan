import 'package:ngam_plan/features/events/models/calculation_types.dart';

extension CalendarDateExtensions on CalculationType {
  DateTime get lastDate {
    final now = DateTime.now();
    switch (this) {
      case CalculationType.birthday:
        return DateTime(now.year, now.month, now.day);
      default:
        return DateTime(now.year + 20);
    }
  }
}
