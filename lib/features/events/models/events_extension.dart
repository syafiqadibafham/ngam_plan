import 'package:ngam_plan/features/events/models/event.dart';
import 'package:ngam_plan/features/events/models/event_extension.dart';

extension EventsExtension on List<Event> {
  List<Event> get sorted {
    return List.of(this)..sort((a, b) => a.upcomingDate.compareTo(b.upcomingDate));
  }
}
