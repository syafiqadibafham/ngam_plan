import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ngam_plan/features/events/models/calculation_types.dart';

part 'event.freezed.dart';
part 'event.g.dart';

@freezed
abstract class Event with _$Event {
  const Event._();
  const factory Event({
    required String id,
    required String name,
    required DateTime date,
    @JsonKey(name: 'calculation_type') required CalculationType calculationType,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'color_hex') String? colorHex,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
}
