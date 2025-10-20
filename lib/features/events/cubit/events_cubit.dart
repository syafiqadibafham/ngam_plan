import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngam_plan/features/events/cubit/events_state.dart';
import 'package:ngam_plan/features/events/models/event_model.dart';

class EventsCubit extends Cubit<EventsState> {
  EventsCubit() : super(const EventsInitial());

  void addEvent(Event event) {
    final newEvents = List<Event>.from(state.events)..add(event);
    emit(EventsLoaded(newEvents));
  }
}
