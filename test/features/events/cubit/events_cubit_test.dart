import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ngam_plan/features/events/cubit/events_cubit.dart';
import 'package:ngam_plan/features/events/models/event.dart';
import 'package:ngam_plan/features/events/models/event_types.dart';
import 'package:ngam_plan/features/events/repositories/event_repository.dart';

class MockEventRepository extends Mock implements EventRepository {}

void main() {
  group('EventsCubit', () {
    late EventsCubit eventsCubit;
    late EventRepository eventRepository;

    setUp(() {
      eventRepository = MockEventRepository();
      eventsCubit = EventsCubit(eventRepository);
    });

    tearDown(() {
      eventsCubit.close();
    });

    test('initial state is EventsState.initial()', () {
      expect(eventsCubit.state, const EventsState.initial());
    });

    group('fetchEvents', () {
      final events = [
        Event(
          id: '1',
          name: 'Test Event',
          date: DateTime.now(),
          type: EventType.general,
        )
      ];

      blocTest<EventsCubit, EventsState>(
        'emits [loading, loaded] when getEvents is successful',
        build: () {
          when(() => eventRepository.getEvents()).thenAnswer((_) async => events);
          return eventsCubit;
        },
        act: (cubit) => cubit.fetchEvents(),
        expect: () => [
          const EventsState.loading(),
          EventsState.loaded(events),
        ],
      );

      blocTest<EventsCubit, EventsState>(
        'emits [loading, error] when getEvents throws an exception',
        build: () {
          when(() => eventRepository.getEvents()).thenThrow(Exception('Error'));
          return eventsCubit;
        },
        act: (cubit) => cubit.fetchEvents(),
        expect: () => [
          const EventsState.loading(),
          const EventsState.error('Exception: Error'),
        ],
      );
    });
  });
}
