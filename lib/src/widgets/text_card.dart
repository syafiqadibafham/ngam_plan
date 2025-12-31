import 'package:flutter/material.dart';

class TextCard extends StatelessWidget {
  const TextCard({super.key, this.title, this.subtitle, this.subtitleColor, this.actionLabel, this.onActionPressed});

  final String? title;
  final String? subtitle;
  final Color? subtitleColor;
  final String? actionLabel;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        //border: Border.all(color: AppColors.glassBorder),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            if (title != null)
              Text(
                title!,
                style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
              ),
            if (subtitle != null)
              Text(
                subtitle!,
                style: TextStyle(color: subtitleColor ?? Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold),
              ),
          ]),
          if (actionLabel != null)
            TextButton(
              onPressed: onActionPressed,
              child: Text(actionLabel!),
            ),
        ],
      ),
    );
  }
}
