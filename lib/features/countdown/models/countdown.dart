import 'package:freezed_annotation/freezed_annotation.dart';

part 'countdown.freezed.dart';

@freezed
abstract class CountdownResult with _$CountdownResult {
  const CountdownResult._();
  const factory CountdownResult({
    required final String milestoneLabel,
    required final Duration duration,
  }) = _CountdownResult;
}
