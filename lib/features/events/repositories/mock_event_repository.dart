import 'package:ngam_plan/features/events/models/event.dart';
import 'package:ngam_plan/features/events/models/calculation_types.dart';
import 'package:ngam_plan/features/events/repositories/event_repository.dart';

class MockEventRepository implements EventRepository {
  final List<Event> _events = [
    Event(
      id: '1',
      name: 'My Birthday',
      date: DateTime(1997, 12, 18),
      calculationType: CalculationType.birthday,
      //imageUrl: 'https://picsum.photos/seed/picsum/200/300',
    ),
    Event(
      id: '2',
      name: 'Wedding Anniversary',
      date: DateTime(2024, 8, 24),
      calculationType: CalculationType.anniversary,
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
  Future<void> updateEvent(Event event) async {
    await Future.delayed(const Duration(seconds: 1));
    final index = _events.indexWhere((e) => e.id == event.id);
    if (index != -1) {
      _events[index] = event;
    }
  }

  @override
  Future<void> deleteEvent(String eventId) async {
    await Future.delayed(const Duration(seconds: 1));
    _events.removeWhere((event) => event.id == eventId);
  }
}
