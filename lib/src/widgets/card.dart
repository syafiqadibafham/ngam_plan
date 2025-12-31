import 'package:flutter/material.dart';

class ContainerCard extends StatelessWidget {
  const ContainerCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
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
}
