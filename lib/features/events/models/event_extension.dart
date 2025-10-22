import 'package:ngam_plan/features/events/models/event.dart';
import 'package:ngam_plan/src/utils/countdown_calculator.dart';

extension EventExtension on Event {
  DateTime get upcomingDate => CountdownCalculator.getNextMilestoneDate(this);
}
