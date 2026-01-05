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
mixin _$CountdownResult {
  String get milestoneLabel;
  Duration get duration;

  /// Create a copy of CountdownResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CountdownResultCopyWith<CountdownResult> get copyWith =>
      _$CountdownResultCopyWithImpl<CountdownResult>(
          this as CountdownResult, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CountdownResult &&
            (identical(other.milestoneLabel, milestoneLabel) ||
                other.milestoneLabel == milestoneLabel) &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @override
  int get hashCode => Object.hash(runtimeType, milestoneLabel, duration);

  @override
  String toString() {
    return 'CountdownResult(milestoneLabel: $milestoneLabel, duration: $duration)';
  }
}

/// @nodoc
abstract mixin class $CountdownResultCopyWith<$Res> {
  factory $CountdownResultCopyWith(
          CountdownResult value, $Res Function(CountdownResult) _then) =
      _$CountdownResultCopyWithImpl;
  @useResult
  $Res call({String milestoneLabel, Duration duration});
}

/// @nodoc
class _$CountdownResultCopyWithImpl<$Res>
    implements $CountdownResultCopyWith<$Res> {
  _$CountdownResultCopyWithImpl(this._self, this._then);

  final CountdownResult _self;
  final $Res Function(CountdownResult) _then;

  /// Create a copy of CountdownResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? milestoneLabel = null,
    Object? duration = null,
  }) {
    return _then(_self.copyWith(
      milestoneLabel: null == milestoneLabel
          ? _self.milestoneLabel
          : milestoneLabel // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// Adds pattern-matching-related methods to [CountdownResult].
extension CountdownResultPatterns on CountdownResult {
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
    TResult Function(_CountdownResult value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CountdownResult() when $default != null:
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
    TResult Function(_CountdownResult value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CountdownResult():
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
    TResult? Function(_CountdownResult value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CountdownResult() when $default != null:
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
    TResult Function(String milestoneLabel, Duration duration)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CountdownResult() when $default != null:
        return $default(_that.milestoneLabel, _that.duration);
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
    TResult Function(String milestoneLabel, Duration duration) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CountdownResult():
        return $default(_that.milestoneLabel, _that.duration);
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
    TResult? Function(String milestoneLabel, Duration duration)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CountdownResult() when $default != null:
        return $default(_that.milestoneLabel, _that.duration);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _CountdownResult extends CountdownResult {
  const _CountdownResult({required this.milestoneLabel, required this.duration})
      : super._();

  @override
  final String milestoneLabel;
  @override
  final Duration duration;

  /// Create a copy of CountdownResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CountdownResultCopyWith<_CountdownResult> get copyWith =>
      __$CountdownResultCopyWithImpl<_CountdownResult>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CountdownResult &&
            (identical(other.milestoneLabel, milestoneLabel) ||
                other.milestoneLabel == milestoneLabel) &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @override
  int get hashCode => Object.hash(runtimeType, milestoneLabel, duration);

  @override
  String toString() {
    return 'CountdownResult(milestoneLabel: $milestoneLabel, duration: $duration)';
  }
}

/// @nodoc
abstract mixin class _$CountdownResultCopyWith<$Res>
    implements $CountdownResultCopyWith<$Res> {
  factory _$CountdownResultCopyWith(
          _CountdownResult value, $Res Function(_CountdownResult) _then) =
      __$CountdownResultCopyWithImpl;
  @override
  @useResult
  $Res call({String milestoneLabel, Duration duration});
}

/// @nodoc
class __$CountdownResultCopyWithImpl<$Res>
    implements _$CountdownResultCopyWith<$Res> {
  __$CountdownResultCopyWithImpl(this._self, this._then);

  final _CountdownResult _self;
  final $Res Function(_CountdownResult) _then;

  /// Create a copy of CountdownResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? milestoneLabel = null,
    Object? duration = null,
  }) {
    return _then(_CountdownResult(
      milestoneLabel: null == milestoneLabel
          ? _self.milestoneLabel
          : milestoneLabel // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

// dart format on
