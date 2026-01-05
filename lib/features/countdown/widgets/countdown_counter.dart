import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ngam_plan/features/countdown/models/duration_extension.dart';

class CountdownCounter extends StatefulWidget {
  const CountdownCounter({super.key, required this.eventDate});

  final DateTime eventDate;

  @override
  State<CountdownCounter> createState() => _CountdownCounterState();
}

class _CountdownCounterState extends State<CountdownCounter> {
  late Timer _timer;
  late Duration _countdown;

  @override
  void initState() {
    super.initState();
    _updateCountdown();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateCountdown();
    });
  }

  void _updateCountdown() {
    if (!mounted) return;
    setState(() {
      _countdown = widget.eventDate.difference(DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLessThanADay = _countdown.days <= 1;
    final labels = isLessThanADay ? _countdown.timeLabels(context) : _countdown.dateLabels(context);
    final date = [_countdown.years, _countdown.months, _countdown.days];
    final time = [_countdown.hours, _countdown.minutes, _countdown.seconds];
    final countdownList = isLessThanADay ? time : date;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < 3; i++) ...[
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
  const _ValueAndLabel({required this.value, required this.label});

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
          ],
        ),
      ),
    );
  }
}