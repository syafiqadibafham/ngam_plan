import 'package:flutter/material.dart';
import 'package:ngam_plan/features/events/models/event.dart';
import 'package:ngam_plan/features/events/models/event_extension.dart';
import 'package:ngam_plan/features/events/models/events_extension.dart';
import 'package:ngam_plan/features/home/widgets/event_home_widget.dart';

class EventsHomeWidget extends StatelessWidget {
  const EventsHomeWidget({super.key, required this.events});

  final List<Event> events;

  @override
  Widget build(BuildContext context) {
    final sortedEvents = events.sorted;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        for (var index = 0; index < sortedEvents.length; index++) ...[
          if (index == 0 || sortedEvents[index].upcomingDate.year != sortedEvents[index - 1].upcomingDate.year) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                sortedEvents[index].upcomingDate.year.toString(),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ],
          EventHomeWidget(event: sortedEvents[index]),
        ],
      ],
    );
  }
}
