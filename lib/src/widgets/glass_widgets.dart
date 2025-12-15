import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ngam_plan/src/core/theme/app_colors.dart';

class GlassContainer extends StatelessWidget {
  const GlassContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius,
    this.borderColor,
    this.backgroundColor,
    this.blur = 15.0,
  });

  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final Color? backgroundColor;
  final double blur;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding ?? const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: backgroundColor ?? AppColors.glassSurface,
              borderRadius: borderRadius ?? BorderRadius.circular(24),
              border: Border.all(
                color: borderColor ?? AppColors.glassBorder,
                width: 1.5,
              ),
              boxShadow: [
                 BoxShadow(
                  color: AppColors.glassShadow,
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
