import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:ngam_plan/features/events/cubit/events_cubit.dart';
import 'package:ngam_plan/features/events/models/event_extension.dart';
import 'package:ngam_plan/features/home/widgets/event_home_widget.dart';
import 'package:ngam_plan/src/core/theme/app_icons.dart';
import 'package:ngam_plan/src/localization/app_localizations.dart';
import 'package:ngam_plan/src/widgets/app_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<EventsCubit>().fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    return AppScreen(
        title: AppLocalizations.of(context)!.appTitle,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: BlocBuilder<EventsCubit, EventsState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const SizedBox.shrink(),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (message) => Center(child: Text(message)),
                  loaded: (events) {
                    final sortedEvents = List.of(events)..sort((a, b) => a.upcomingDate.compareTo(b.upcomingDate));

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocalizations.of(context)!.upcomingEventsTitle, style: Theme.of(context).textTheme.headlineMedium),
                        const SizedBox(height: 8),
                        MediaQuery.removePadding(
                          context: context,
                          removeBottom: true,
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: sortedEvents.length,
                            itemBuilder: (context, index) {
                              final event = sortedEvents[index];
                              return EventHomeWidget(event: event);
                            },
                            separatorBuilder: (context, index) => const SizedBox(height: 8),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text("Overview", style: Theme.of(context).textTheme.headlineMedium),
                        const SizedBox(height: 8),
                        GridView.count(
                          crossAxisCount: 3,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: List.generate(3, (index) {
                            final now = DateTime.now();
                            final month = DateTime(now.year, now.month + index, 1);

                            final eventsInMonth = events.where((event) {
                              final upcomingDate = event.upcomingDate;
                              return upcomingDate.year == month.year && upcomingDate.month == month.month;
                            }).length;

                            return Center(
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(AppIcons.event, color: Theme.of(context).colorScheme.onSecondary),
                                        const SizedBox(width: 8),
                                        Text(
                                          eventsInMonth.toString(),
                                          style: Theme.of(context).textTheme.headlineLarge,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      Jiffy.parseFromDateTime(month).format(pattern: 'MMM yy'),
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ));
  }
}
