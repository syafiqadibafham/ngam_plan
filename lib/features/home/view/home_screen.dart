import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngam_plan/features/events/cubit/events_cubit.dart';
import 'package:ngam_plan/features/home/widgets/event_home_widget.dart';
import 'package:ngam_plan/src/localization/app_localizations.dart';
import 'package:ngam_plan/src/utils/countdown_calculator.dart';
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
            child: Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.upcomingEventsTitle, style: Theme.of(context).textTheme.headlineMedium),
                BlocBuilder<EventsCubit, EventsState>(
                  builder: (context, state) {
                    return state.when(
                      initial: () => const SizedBox.shrink(),
                      loading: () => const Center(child: CircularProgressIndicator()),
                      loaded: (events) {
                        if (events.isEmpty) {
                          return Center(child: Text(AppLocalizations.of(context)!.noUpcomingEvents));
                        }

                        final sortedEvents = List.of(events)
                          ..sort((a, b) {
                            final aDate = CountdownCalculator.getNextMilestoneDate(a);
                            final bDate = CountdownCalculator.getNextMilestoneDate(b);
                            return aDate.compareTo(bDate);
                          });
                        return Column(
                          children: sortedEvents.map((event) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: EventHomeWidget(event: event),
                            );
                          }).toList(),
                        );
                      },
                      error: (message) => Center(child: Text(message)),
                    );
                  },
                ),
                Text(AppLocalizations.of(context)!.thisMonthsEventsTitle, style: Theme.of(context).textTheme.headlineMedium),
                GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  // Generate 100 widgets that display their index in the list.
                  children: List.generate(4, (index) {
                    return Center(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.item(index),
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ));
  }
}
