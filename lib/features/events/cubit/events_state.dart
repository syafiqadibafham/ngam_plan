import 'package:equatable/equatable.dart';
import 'package:ngam_plan/features/events/models/event_model.dart';

abstract class EventsState extends Equatable {
  final List<Event> events;

  const EventsState(this.events);

  @override
  List<Object> get props => [events];
}

class EventsInitial extends EventsState {
  const EventsInitial() : super(const []);
}

class EventsLoaded extends EventsState {
  const EventsLoaded(super.events);
}