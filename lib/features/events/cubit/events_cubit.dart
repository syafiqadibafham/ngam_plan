import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ngam_plan/features/events/models/event.dart';
import 'package:ngam_plan/features/events/repositories/event_repository.dart';

part 'events_cubit.freezed.dart';
part 'events_state.dart';

class EventsCubit extends Cubit<EventsState> {
  EventsCubit(this._eventRepository) : super(const EventsState.initial());

  final EventRepository _eventRepository;

  Future<void> fetchEvents() async {
    emit(const EventsState.loading());
    try {
      final events = await _eventRepository.getEvents();
      emit(EventsState.loaded(events));
    } catch (e) {
      emit(EventsState.error(e.toString()));
    }
  }

  Future<void> addEvent(Event event) async {
    try {
      await _eventRepository.addEvent(event);
      await fetchEvents();
    } catch (e) {
      emit(EventsState.error(e.toString()));
    }
  }

  Future<void> deleteEvent(String eventId) async {
    try {
      await _eventRepository.deleteEvent(eventId);
      fetchEvents();
    } catch (e) {
      emit(EventsState.error(e.toString()));
    }
  }
}
