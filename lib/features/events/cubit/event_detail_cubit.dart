import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ngam_plan/features/events/models/event.dart';
import 'package:ngam_plan/features/events/repositories/event_repository.dart';

part 'event_detail_cubit.freezed.dart';
part 'event_detail_state.dart';

class EventDetailCubit extends Cubit<EventDetailState> {
  EventDetailCubit(this._eventRepository) : super(const EventDetailState.initial());

  final EventRepository _eventRepository;

  Future<void> fetchEvent(String eventId) async {
    emit(const EventDetailState.loading());
    try {
      final event = await _eventRepository.getEvent(eventId);
      emit(EventDetailState.loaded(event));
    } catch (e) {
      emit(EventDetailState.error(e.toString()));
    }
  }
}
