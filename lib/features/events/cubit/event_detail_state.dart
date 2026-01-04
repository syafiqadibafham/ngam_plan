part of 'event_detail_cubit.dart';

@freezed
class EventDetailState with _$EventDetailState {
  const factory EventDetailState.initial() = _Initial;
  const factory EventDetailState.loading() = _Loading;
  const factory EventDetailState.loaded(Event event) = _Loaded;
  const factory EventDetailState.error(String message) = _Error;
}
