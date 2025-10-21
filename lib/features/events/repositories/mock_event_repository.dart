import 'package:ngam_plan/features/events/models/event.dart';
import 'package:ngam_plan/features/events/models/event_types.dart';
import 'package:ngam_plan/features/events/repositories/event_repository.dart';

class MockEventRepository implements EventRepository {
  final List<Event> _events = [
    Event(
      id: '1',
      name: 'John\'s Birthday',
      date: DateTime(2024, 10, 26),
      type: EventType.birthday,
    ),
    Event(
      id: '2',
      name: 'Wedding Anniversary',
      date: DateTime(2024, 12, 15),
      type: EventType.anniversary,
    ),
  ];

  @override
  Future<List<Event>> getEvents() async {
    await Future.delayed(const Duration(seconds: 1));
    return _events;
  }

  @override
  Future<void> addEvent(Event event) async {
    await Future.delayed(const Duration(seconds: 1));
    _events.add(event);
  }

  @override
  Future<void> deleteEvent(String eventId) async {
    await Future.delayed(const Duration(seconds: 1));
    _events.removeWhere((event) => event.id == eventId);
  }
}
