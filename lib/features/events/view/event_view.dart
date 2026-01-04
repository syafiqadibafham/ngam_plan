import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngam_plan/features/events/cubit/event_detail_cubit.dart';
import 'package:ngam_plan/features/events/cubit/events_cubit.dart';
import 'package:ngam_plan/features/events/models/event.dart';
import 'package:ngam_plan/features/events/models/event_extension.dart';
import 'package:ngam_plan/features/events/repositories/event_repository.dart';
import 'package:ngam_plan/service_locator.dart';
import 'package:ngam_plan/src/core/theme/app_icons.dart';
import 'package:ngam_plan/src/utils/countdown_calculator.dart';
import 'package:ngam_plan/src/widgets/app_screen.dart';
import 'package:ngam_plan/src/widgets/card.dart';
import 'package:ngam_plan/src/widgets/text_card.dart';

class EventView extends StatelessWidget {
  const EventView({super.key, required this.eventId});

  final String eventId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventDetailCubit(getIt<EventRepository>())..fetchEvent(eventId),
      child: BlocBuilder<EventDetailCubit, EventDetailState>(
        builder: (context, state) {
          Event? event;
          bool isLoading = true;
          state.when(
            initial: () => isLoading = true,
            loading: () => isLoading = true,
            loaded: (eventData) {
              event = eventData;
              isLoading = false;
            },
            error: (message) => Center(child: Text(message)),
          );
          final countdownString = event != null ? CountdownCalculator.getCountdownString(event!, context) : "";
          return AppScreen(
            title: event?.name ?? 'Event Details',
            topRightWidgets: [
              if (event != null)
                IconButton(
                  icon: Icon(
                    AppIcons.delete,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  onPressed: () {
                    context.read<EventsCubit>().deleteEvent(event!.id);
                    Navigator.of(context).pop();
                  },
                ),
            ],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                ContainerCard(
                    child: Text(
                  countdownString,
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w900,
                  ),
                )),
                TextCard(
                  isLoading: isLoading,
                  title: "Event Name",
                  subtitle: event?.name,
                ),
                TextCard(
                  isLoading: isLoading,
                  title: "Start Date",
                  subtitle: event?.startDate.toLocal().toString().split(' ')[0],
                ),
                TextCard(
                  isLoading: isLoading,
                  title: "Next Occurrence",
                  subtitle: event?.upcomingDate.toLocal().toString().split(' ')[0],
                ),
                TextCard(
                  isLoading: isLoading,
                  title: "Calculation Type",
                  subtitle: event?.calculationType.name,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
