import 'package:ngam_plan/features/events/models/event.dart';

abstract class EventRepository {
  Future<List<Event>> getEvents();
  Future<void> addEvent(Event event);
  Future<void> deleteEvent(String eventId);
}
