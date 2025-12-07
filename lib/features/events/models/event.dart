import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ngam_plan/features/events/models/event_types.dart';

part 'event.freezed.dart';

@freezed
class Event with _$Event {
  const factory Event({
    required String id,
    required String name,
    required DateTime date,
    required EventType type,
    String? imageUrl,
    Color? color,
  }) = _Event;
}
