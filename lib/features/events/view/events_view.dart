import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngam_plan/features/events/cubit/events_cubit.dart';
import 'package:ngam_plan/features/events/view/add_event_view.dart';
import 'package:ngam_plan/service_locator.dart';
import 'package:ngam_plan/src/core/theme/app_colors.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ngam_plan/src/core/theme/app_icons.dart';
import 'package:ngam_plan/src/widgets/glass_widgets.dart';
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
            Navigator.of(context).push((MaterialPageRoute(builder: (context) => const AddEventSheet()))).then((_) {
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
                  padding: const EdgeInsets.only(bottom: 100),
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: GlassContainer(
                        padding: EdgeInsets.zero,
                        child: ListTile(
                          leading: const Icon(LucideIcons.calendar),
                          title: Text(event.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(event.date.toLocal().toString().split(' ')[0]),
                          trailing: IconButton(
                            icon: const Icon(LucideIcons.trash2, color: AppColors.error),
                            onPressed: () {
                              context.read<EventsCubit>().deleteEvent(event.id);
                            },
                          ),
                        ),
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
