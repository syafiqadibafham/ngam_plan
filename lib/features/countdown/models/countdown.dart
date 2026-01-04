import 'package:freezed_annotation/freezed_annotation.dart';

part 'countdown.freezed.dart';

@freezed
abstract class Countdown with _$Countdown {
  const Countdown._();
  const factory Countdown({
    required int year,
    required int month,
    required int day,
    required int hours,
    required int minutes,
    required int seconds,
  }) = _Countdown;

  bool get isLessThanADay {
    return year == 0 && month == 0 && day == 0;
  }

  factory Countdown.fromDateTime(DateTime dateTime) {
    final difference = dateTime.difference(DateTime.now());

    return Countdown(
      year: difference.inDays ~/ 365,
      month: (difference.inDays % 365) ~/ 30,
      day: difference.inDays % 30,
      hours: dateTime.hour,
      minutes: dateTime.minute,
      seconds: dateTime.second,
    );
  }
}
