import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:ngam_plan/src/core/theme/app_colors.dart';

class AnimatedBackground extends StatelessWidget {
  const AnimatedBackground({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1. Gradient
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.backgroundStart,
                AppColors.backgroundEnd,
              ],
            ),
          ),
        ).animate(onPlay: (controller) => controller.repeat(reverse: true)).shimmer(duration: 5.seconds, color: AppColors.accentStart.withAlpha(10)),

        // // 2. Orbs
        // Positioned(
        //   top: -100,
        //   left: -100,
        //   child: Container(
        //     width: 300,
        //     height: 300,
        //     decoration: BoxDecoration(
        //       shape: BoxShape.circle,
        //       color: AppColors.primary.withAlpha(13),
        //       backgroundBlendMode: BlendMode.overlay,
        //     ),
        //   ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(duration: 4.seconds, begin: const Offset(1, 1), end: const Offset(1.2, 1.2)),
        // ),
        // Positioned(
        //   bottom: 100,
        //   right: -50,
        //   child: Container(
        //     width: 250,
        //     height: 250,
        //     decoration: BoxDecoration(
        //       shape: BoxShape.circle,
        //       color: AppColors.secondary.withAlpha(51),
        //       backgroundBlendMode: BlendMode.overlay,
        //     ),
        //   ).animate(onPlay: (c) => c.repeat(reverse: true)).moveY(duration: 6.seconds, begin: 0, end: 30),
        // ),

        // 3. Child content
        if (child != null) child!,
      ],
    );
  }
}
