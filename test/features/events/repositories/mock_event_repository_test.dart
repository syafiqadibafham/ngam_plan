import 'package:flutter_test/flutter_test.dart';
import 'package:ngam_plan/features/events/models/event.dart';
import 'package:ngam_plan/features/events/models/event_types.dart';
import 'package:ngam_plan/features/events/repositories/mock_event_repository.dart';

void main() {
  group('MockEventRepository', () {
    late MockEventRepository repository;

    setUp(() {
      repository = MockEventRepository();
    });

    test('getEvents returns a list of events', () async {
      final events = await repository.getEvents();
      expect(events, isA<List<Event>>());
    });

    test('addEvent adds an event to the list', () async {
      final event = Event(
        id: '3',
        name: 'Test Event',
        date: DateTime.now(),
        type: EventType.general,
      );
      await repository.addEvent(event);
      final events = await repository.getEvents();
      expect(events, contains(event));
    });

    test('deleteEvent removes an event from the list', () async {
      final event = Event(
        id: '3',
        name: 'Test Event',
        date: DateTime.now(),
        type: EventType.general,
      );
      await repository.addEvent(event);
      await repository.deleteEvent(event.id);
      final events = await repository.getEvents();
      expect(events, isNot(contains(event)));
    });
  });
}
