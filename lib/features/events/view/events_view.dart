import 'package:flutter/material.dart';
import 'package:ngam_plan/src/core/theme/app_icons.dart';
import 'package:ngam_plan/src/localization/app_localizations.dart';
import 'package:ngam_plan/src/widgets/app_screen.dart';

class EventsView extends StatelessWidget {
  const EventsView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      title: AppLocalizations.of(context)!.eventsSectionTitle,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action to add a new event
        },
        child: const Icon(AppIcons.add),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 10, // Example item count
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(AppIcons.event),
            title: Text('Event $index'),
            subtitle: const Text('Event details go here'),
          );
        },
      ),
    );
  }
}
