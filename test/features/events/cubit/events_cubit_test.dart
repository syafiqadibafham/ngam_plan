import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ngam_plan/features/events/cubit/events_cubit.dart';
import 'package:ngam_plan/features/events/models/event.dart';
import 'package:ngam_plan/features/events/models/calculation_types.dart';
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
          calculationType: CalculationType.general,
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

    group('addEvent', () {
      final event = Event(
        id: '2',
        name: 'New Event',
        date: DateTime.now(),
        calculationType: CalculationType.general,
      );
      final events = [
        Event(
          id: '1',
          name: 'Test Event',
          date: DateTime.now(),
          calculationType: CalculationType.general,
        ),
        event,
      ];

      blocTest<EventsCubit, EventsState>(
        'calls addEvent and then fetchEvents, emits [loading, loaded]',
        build: () {
          when(() => eventRepository.addEvent(event)).thenAnswer((_) async {});
          when(() => eventRepository.getEvents()).thenAnswer((_) async => events);
          return eventsCubit;
        },
        act: (cubit) => cubit.addEvent(event),
        expect: () => [
          const EventsState.loading(),
          EventsState.loaded(events),
        ],
        verify: (_) {
          verify(() => eventRepository.addEvent(event)).called(1);
          verify(() => eventRepository.getEvents()).called(1);
        },
      );

      blocTest<EventsCubit, EventsState>(
        'emits [error] when addEvent throws an exception',
        build: () {
          when(() => eventRepository.addEvent(event)).thenThrow(Exception('Error'));
          return eventsCubit;
        },
        act: (cubit) => cubit.addEvent(event),
        expect: () => [
          const EventsState.error('Exception: Error'),
        ],
      );
    });

    group('deleteEvent', () {
      const eventId = '1';
      final events = [
        Event(
          id: '2',
          name: 'Another Event',
          date: DateTime.now(),
          calculationType: CalculationType.general,
        ),
      ];

      blocTest<EventsCubit, EventsState>(
        'calls deleteEvent and then fetchEvents, emits [loading, loaded]',
        build: () {
          when(() => eventRepository.deleteEvent(eventId)).thenAnswer((_) async {});
          when(() => eventRepository.getEvents()).thenAnswer((_) async => events);
          return eventsCubit;
        },
        act: (cubit) => cubit.deleteEvent(eventId),
        expect: () => [
          const EventsState.loading(),
          EventsState.loaded(events),
        ],
        verify: (_) {
          verify(() => eventRepository.deleteEvent(eventId)).called(1);
          verify(() => eventRepository.getEvents()).called(1);
        },
      );

      blocTest<EventsCubit, EventsState>(
        'emits [error] when deleteEvent throws an exception',
        build: () {
          when(() => eventRepository.deleteEvent(eventId)).thenThrow(Exception('Error'));
          return eventsCubit;
        },
        act: (cubit) => cubit.deleteEvent(eventId),
        expect: () => [
          const EventsState.error('Exception: Error'),
        ],
      );
    });
  });
}
