import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngam_plan/features/events/cubit/events_cubit.dart';
import 'package:ngam_plan/service_locator.dart';
import 'package:ngam_plan/src/core/theme/app_colors.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ngam_plan/src/widgets/glass_widgets.dart';

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

  Future<void> _onRefresh() async {
    await context.read<EventsCubit>().fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsCubit, EventsState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: _onRefresh,
          color: Theme.of(context).colorScheme.primary,
          child: state.when(
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
          ),
        );
      },
    );
  }
}
