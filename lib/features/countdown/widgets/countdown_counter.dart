import 'package:flutter/material.dart';
import 'package:ngam_plan/features/countdown/models/countdown.dart';
import 'package:ngam_plan/features/countdown/models/countdown_extension.dart';

class CountdownCounter extends StatelessWidget {
  const CountdownCounter({super.key, required this.countdown});

  final Countdown countdown;

  @override
  Widget build(BuildContext context) {
    final countdownList = countdown.toList();
    final labels = countdown.labels(context);
    final startLabel = countdownList.indexWhere((value) => value != 0);
    return Row(
      children: [
        for (var i = startLabel; i < (3 + startLabel); i++) ...[
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: _ValueAndLabel(value: countdownList[i].toString(), label: labels[i]),
          ),
        ],
      ],
    );
  }
}

class _ValueAndLabel extends StatelessWidget {
  const _ValueAndLabel({super.key, required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              value,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.surface,
                  ),
            ),
            Text(label,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.surface,
                    ))
            // Additional countdown logic and UI here
          ],
        ),
      ),
    );
  }
}
