import 'package:flutter/material.dart';
import 'package:ngam_plan/src/widgets/card.dart';

class TextCard extends StatelessWidget {
  const TextCard({super.key, this.title, this.subtitle, this.subtitleColor, this.actionLabel, this.onActionPressed, this.isLoading = false});

  final String? title;
  final String? subtitle;
  final Color? subtitleColor;
  final String? actionLabel;
  final VoidCallback? onActionPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ContainerCard(
      isLoading: isLoading,
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
