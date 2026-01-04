import 'package:ngam_plan/features/events/models/event.dart';

abstract class EventRepository {
  Future<List<Event>> getEvents();
  Future<Event> getEvent(String eventId);
  Future<void> addEvent(Event event);
  Future<void> updateEvent(Event event);
  Future<void> deleteEvent(String eventId);
}
