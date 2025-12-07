import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/material.dart';

class CustomInputBorder extends OutlineInputBorder {
  final Gradient? gradient;

  const CustomInputBorder({
    super.borderSide = const BorderSide(),
    super.borderRadius = const BorderRadius.all(Radius.circular(4.0)),
    super.gapPadding = 4.0,
    this.gradient,
  });

  @override
  CustomInputBorder copyWith({
    BorderSide? borderSide,
    BorderRadius? borderRadius,
    double? gapPadding,
    Gradient? gradient,
  }) {
    return CustomInputBorder(
      borderSide: borderSide ?? this.borderSide,
      borderRadius: borderRadius ?? this.borderRadius,
      gapPadding: gapPadding ?? this.gapPadding,
      gradient: gradient ?? this.gradient,
    );
  }

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is CustomInputBorder) {
      return CustomInputBorder(
        borderRadius: BorderRadius.lerp(a.borderRadius, borderRadius, t)!,
        borderSide: BorderSide.lerp(a.borderSide, borderSide, t),
        gapPadding: lerpDouble(a.gapPadding, gapPadding, t)!,
        gradient: Gradient.lerp(a.gradient, gradient, t),
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is CustomInputBorder) {
      return CustomInputBorder(
        borderRadius: BorderRadius.lerp(borderRadius, b.borderRadius, t)!,
        borderSide: BorderSide.lerp(borderSide, b.borderSide, t),
        gapPadding: lerpDouble(gapPadding, b.gapPadding, t)!,
        gradient: Gradient.lerp(gradient, b.gradient, t),
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double? gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    TextDirection? textDirection,
  }) {
    final Paint paint = borderSide.toPaint();
    final RRect outer = borderRadius.toRRect(rect);
    final RRect center = outer.deflate(borderSide.width / 2.0);
    if (gradient != null) {
      paint.shader = gradient!.createShader(rect);
    }

    if (gapStart == null || gapExtent <= 0.0 || gapPercentage == 0.0) {
      canvas.drawRRect(center, paint);
    } else {
      final double extent = lerpDouble(0.0, gapExtent, gapPercentage)!;
      switch (textDirection!) {
        case TextDirection.rtl:
          final Path path = _gapBorderPath(center, math.max(0.0, gapStart - extent), extent);
          canvas.drawPath(path, paint);
          break;
        case TextDirection.ltr:
          final Path path = _gapBorderPath(center, gapStart, extent);
          canvas.drawPath(path, paint);
          break;
      }
    }
  }

  Path _gapBorderPath(RRect center, double start, double extent) {
    final Path path = Path()..addRRect(center);
    final Rect gap = Rect.fromLTWH(
      start,
      center.top,
      extent,
      borderSide.width,
    );
    path.addRect(gap.inflate(borderSide.width / 2.0));
    path.fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is CustomInputBorder && other.borderSide == borderSide && other.borderRadius == borderRadius && other.gapPadding == gapPadding && other.gradient == gradient;
  }

  @override
  int get hashCode => Object.hash(borderSide, borderRadius, gapPadding, gradient);
}
