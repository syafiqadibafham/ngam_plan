import 'package:ngam_plan/features/events/models/event.dart';
import 'package:ngam_plan/features/events/models/event_types.dart';
import 'package:ngam_plan/features/events/repositories/event_repository.dart';

class MockEventRepository implements EventRepository {
  final List<Event> _events = [
    Event(
      id: '1',
      name: 'My Birthday',
      date: DateTime(1997, 12, 18),
      type: EventType.birthday,
      //imageUrl: 'https://picsum.photos/seed/picsum/200/300',
    ),
    Event(
      id: '2',
      name: 'Wedding Anniversary',
      date: DateTime(2024, 8, 24),
      type: EventType.anniversary,
      imageUrl: "https://picsum.photos/200/300",
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
