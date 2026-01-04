// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'countdown.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Countdown {
  int get year;
  int get month;
  int get day;
  int get hours;
  int get minutes;
  int get seconds;

  /// Create a copy of Countdown
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CountdownCopyWith<Countdown> get copyWith =>
      _$CountdownCopyWithImpl<Countdown>(this as Countdown, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Countdown &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.hours, hours) || other.hours == hours) &&
            (identical(other.minutes, minutes) || other.minutes == minutes) &&
            (identical(other.seconds, seconds) || other.seconds == seconds));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, year, month, day, hours, minutes, seconds);

  @override
  String toString() {
    return 'Countdown(year: $year, month: $month, day: $day, hours: $hours, minutes: $minutes, seconds: $seconds)';
  }
}

/// @nodoc
abstract mixin class $CountdownCopyWith<$Res> {
  factory $CountdownCopyWith(Countdown value, $Res Function(Countdown) _then) =
      _$CountdownCopyWithImpl;
  @useResult
  $Res call(
      {int year, int month, int day, int hours, int minutes, int seconds});
}

/// @nodoc
class _$CountdownCopyWithImpl<$Res> implements $CountdownCopyWith<$Res> {
  _$CountdownCopyWithImpl(this._self, this._then);

  final Countdown _self;
  final $Res Function(Countdown) _then;

  /// Create a copy of Countdown
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? month = null,
    Object? day = null,
    Object? hours = null,
    Object? minutes = null,
    Object? seconds = null,
  }) {
    return _then(_self.copyWith(
      year: null == year
          ? _self.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      month: null == month
          ? _self.month
          : month // ignore: cast_nullable_to_non_nullable
              as int,
      day: null == day
          ? _self.day
          : day // ignore: cast_nullable_to_non_nullable
              as int,
      hours: null == hours
          ? _self.hours
          : hours // ignore: cast_nullable_to_non_nullable
              as int,
      minutes: null == minutes
          ? _self.minutes
          : minutes // ignore: cast_nullable_to_non_nullable
              as int,
      seconds: null == seconds
          ? _self.seconds
          : seconds // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [Countdown].
extension CountdownPatterns on Countdown {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Countdown value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Countdown() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Countdown value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Countdown():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Countdown value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Countdown() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            int year, int month, int day, int hours, int minutes, int seconds)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Countdown() when $default != null:
        return $default(_that.year, _that.month, _that.day, _that.hours,
            _that.minutes, _that.seconds);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            int year, int month, int day, int hours, int minutes, int seconds)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Countdown():
        return $default(_that.year, _that.month, _that.day, _that.hours,
            _that.minutes, _that.seconds);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            int year, int month, int day, int hours, int minutes, int seconds)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Countdown() when $default != null:
        return $default(_that.year, _that.month, _that.day, _that.hours,
            _that.minutes, _that.seconds);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Countdown extends Countdown {
  const _Countdown(
      {required this.year,
      required this.month,
      required this.day,
      required this.hours,
      required this.minutes,
      required this.seconds})
      : super._();

  @override
  final int year;
  @override
  final int month;
  @override
  final int day;
  @override
  final int hours;
  @override
  final int minutes;
  @override
  final int seconds;

  /// Create a copy of Countdown
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CountdownCopyWith<_Countdown> get copyWith =>
      __$CountdownCopyWithImpl<_Countdown>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Countdown &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.hours, hours) || other.hours == hours) &&
            (identical(other.minutes, minutes) || other.minutes == minutes) &&
            (identical(other.seconds, seconds) || other.seconds == seconds));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, year, month, day, hours, minutes, seconds);

  @override
  String toString() {
    return 'Countdown(year: $year, month: $month, day: $day, hours: $hours, minutes: $minutes, seconds: $seconds)';
  }
}

/// @nodoc
abstract mixin class _$CountdownCopyWith<$Res>
    implements $CountdownCopyWith<$Res> {
  factory _$CountdownCopyWith(
          _Countdown value, $Res Function(_Countdown) _then) =
      __$CountdownCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int year, int month, int day, int hours, int minutes, int seconds});
}

/// @nodoc
class __$CountdownCopyWithImpl<$Res> implements _$CountdownCopyWith<$Res> {
  __$CountdownCopyWithImpl(this._self, this._then);

  final _Countdown _self;
  final $Res Function(_Countdown) _then;

  /// Create a copy of Countdown
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? year = null,
    Object? month = null,
    Object? day = null,
    Object? hours = null,
    Object? minutes = null,
    Object? seconds = null,
  }) {
    return _then(_Countdown(
      year: null == year
          ? _self.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      month: null == month
          ? _self.month
          : month // ignore: cast_nullable_to_non_nullable
              as int,
      day: null == day
          ? _self.day
          : day // ignore: cast_nullable_to_non_nullable
              as int,
      hours: null == hours
          ? _self.hours
          : hours // ignore: cast_nullable_to_non_nullable
              as int,
      minutes: null == minutes
          ? _self.minutes
          : minutes // ignore: cast_nullable_to_non_nullable
              as int,
      seconds: null == seconds
          ? _self.seconds
          : seconds // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
