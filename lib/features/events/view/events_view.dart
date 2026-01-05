import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ngam_plan/core/routing/app_routes.dart';
import 'package:ngam_plan/features/events/cubit/events_cubit.dart';
import 'package:ngam_plan/features/events/models/event_extension.dart';
import 'package:ngam_plan/src/core/theme/app_icons.dart';
import 'package:ngam_plan/src/widgets/card.dart';
import 'package:ngam_plan/features/countdown/widgets/countdown_counter.dart';

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
                    child: GestureDetector(
                      onTap: () => context.pushNamed(AppRoutes.event.name, pathParameters: {'id': event.id}),
                      child: ContainerCard(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          spacing: 10,
                          children: [
                            const Icon(AppIcons.event),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(event.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                                  Text(event.startDate.toLocal().toString().split(' ')[0]),
                                ],
                              ),
                            ),
                            CountdownCounter(eventDate: event.upcomingDate)
                          ],
                          //Icon(AppIcons.right, color: Theme.of(context).disabledColor),
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
