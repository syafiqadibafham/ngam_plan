import 'package:flutter/material.dart';
import 'package:ngam_plan/src/core/theme/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class ContainerCard extends StatelessWidget {
  const ContainerCard({super.key, required this.child, this.isLoading = false});

  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (!isLoading) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          //border: Border.all(color: AppColors.glassBorder),
        ),
        child: child,
      );
    }

    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.surface,
      highlightColor: AppColors.glassBorder,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          //border: Border.all(color: AppColors.glassBorder),
        ),
        child: Opacity(opacity: isLoading ? 0 : 1.0, child: child),
      ),
    );
  }
}
