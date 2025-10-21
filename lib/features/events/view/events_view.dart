import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngam_plan/features/events/cubit/events_cubit.dart';
import 'package:ngam_plan/features/events/view/add_event_view.dart';
import 'package:ngam_plan/service_locator.dart';
import 'package:ngam_plan/src/core/theme/app_icons.dart';
import 'package:ngam_plan/src/localization/app_localizations.dart';
import 'package:ngam_plan/src/widgets/app_screen.dart';

class EventsView extends StatefulWidget {
  const EventsView({super.key});

  @override
  State<EventsView> createState() => _EventsViewState();
}

class _EventsViewState extends State<EventsView> {
  @override
  void initState() {
    super.initState();
    context.read<EventsCubit>().fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EventsCubit>()..fetchEvents(),
      child: AppScreen(
        title: AppLocalizations.of(context)!.eventsSectionTitle,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push((MaterialPageRoute(builder: (context) => const AddEventView()))).then((_) {
              setState(() {});
            });
          },
          child: const Icon(AppIcons.add),
        ),
        child: BlocBuilder<EventsCubit, EventsState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (events) {
                if (events.isEmpty) {
                  return const Center(child: Text('No events yet.'));
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    return ListTile(
                      leading: const Icon(AppIcons.event),
                      title: Text(event.name),
                      subtitle: Text(event.date.toLocal().toString().split(' ')[0]),
                      trailing: IconButton(
                        icon: const Icon(AppIcons.delete),
                        onPressed: () {
                          context.read<EventsCubit>().deleteEvent(event.id);
                        },
                      ),
                    );
                  },
                );
              },
              error: (message) => Center(child: Text(message)),
            );
          },
        ),
      ),
    );
  }
}
