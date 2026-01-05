import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:ngam_plan/features/countdown/widgets/countdown_counter.dart';
import 'package:ngam_plan/features/events/cubit/event_detail_cubit.dart';
import 'package:ngam_plan/features/events/cubit/events_cubit.dart';
import 'package:ngam_plan/features/events/models/calculation_types.dart';
import 'package:ngam_plan/features/events/models/event.dart';
import 'package:ngam_plan/features/events/models/event_extension.dart';
import 'package:ngam_plan/features/events/repositories/event_repository.dart';
import 'package:ngam_plan/features/events/widgets/calculation_type_selector.dart';
import 'package:ngam_plan/service_locator.dart';
import 'package:ngam_plan/src/core/theme/app_icons.dart';
import 'package:ngam_plan/src/core/theme/app_ui.dart';
import 'package:ngam_plan/src/localization/app_localizations.dart';
import 'package:ngam_plan/src/utils/countdown_calculator.dart';
import 'package:ngam_plan/src/widgets/app_screen.dart';
import 'package:ngam_plan/src/widgets/button.dart';
import 'package:ngam_plan/src/widgets/card.dart';
import 'package:ngam_plan/src/widgets/date_selector.dart';
import 'package:ngam_plan/src/widgets/text_card.dart';
import 'package:ngam_plan/src/widgets/text_input.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class EventView extends StatefulWidget {
  const EventView({super.key, required this.eventId});

  final String eventId;

  @override
  State<EventView> createState() => _EventViewState();
}

class _EventViewState extends State<EventView> {
  final _nameController = TextEditingController();
  Event? event;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventDetailCubit(getIt<EventRepository>())..fetchEvent(widget.eventId),
      child: BlocConsumer<EventDetailCubit, EventDetailState>(
        listener: (context, state) {
          state.whenOrNull(
            loaded: (eventData) {
              _nameController.text = eventData.name;
            },
          );
        },
        builder: (context, state) {
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

          final countdownString = event != null ? CountdownCalculator.getCountdown(event!, context).milestoneLabel : "";
          return AppScreen(
            title: event?.name ?? AppLocalizations.of(context)!.eventDetailsTitle,
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
                if (!isLoading && event == null)
                  ContainerCard(child: Text("Event not found."))
                else ...[
                  if (event != null)
                    ContainerCard(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 10,
                            children: [
                              Text(countdownString, style: Theme.of(context).textTheme.headlineMedium),
                              CountdownCounter(eventDate: event!.upcomingDate),
                            ],
                          ),
                        )),
                  if (event != null)
                    CalculationTypeSelector(
                      selectedCalculationType: event!.calculationType,
                      onDone: (value) async {
                        if (event == null) return;
                        event = event!.copyWith(calculationType: value);
                        await context.read<EventsCubit>().updateEvent(event!);
                        await context.read<EventDetailCubit>().fetchEvent(event!.id);
                      },
                    ),
                  TextCard(
                    isLoading: isLoading,
                    title: AppLocalizations.of(context)!.eventNameLabel,
                    subtitle: event?.name,
                    actionLabel: AppLocalizations.of(context)!.change,
                    onActionPressed: () => AppHelpers.showBottomSheet(context,
                        child: _TextInputChangeSheet(
                          label: AppLocalizations.of(context)!.eventNameLabel,
                          controller: _nameController,
                          onDone: (_) async {
                            if (event == null) return;
                            event = event?.copyWith(name: _nameController.text);
                            await context.read<EventsCubit>().updateEvent(event!);
                            await context.read<EventDetailCubit>().fetchEvent(event!.id);
                          },
                        )),
                  ),
                  if (event != null)
                    DateSelector(
                      label: AppLocalizations.of(context)!.startDateLabel,
                      selectedDate: event?.startDate,
                      selectedCalculationType: event!.calculationType,
                      onDateChanged: (date) async {
                        if (event == null) return;
                        event = event?.copyWith(startDate: date);
                        await context.read<EventsCubit>().updateEvent(event!);
                        await context.read<EventDetailCubit>().fetchEvent(event!.id);
                      },
                    ),
                  if (event != null && event!.calculationType == CalculationType.range)
                    TextCard(
                      isLoading: isLoading,
                      title: AppLocalizations.of(context)!.endDateLabel,
                      subtitle: event?.endDate == null ? "Not Defined yet" : Jiffy.parseFromDateTime(event!.endDate!.toLocal()).format(pattern: "dd MMM yyyy"),
                    ),
                  TextCard(
                    isLoading: isLoading,
                    title: AppLocalizations.of(context)!.nextOccurrenceLabel,
                    subtitle: event == null ? "" : Jiffy.parseFromDateTime(event!.upcomingDate.toLocal()).format(pattern: "dd MMM yyyy"),
                  ),
                ]
              ],
            ),
          );
        },
      ),
    );
  }
}

class _TextInputChangeSheet extends StatelessWidget {
  _TextInputChangeSheet({required this.label, required this.controller, required this.onDone});

  final String label;
  final TextEditingController controller;
  final Function(String query) onDone;

  @override
  Widget build(BuildContext context) {
    return Sheet(
      decoration: MaterialSheetDecoration(
        size: SheetSize.fit,
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
      ),
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Update $label",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              TextInput(
                controller: controller,
                labelText: label,
              ),
              Button(
                  label: AppLocalizations.of(context)!.done,
                  onPressed: () {
                    try {
                      onDone(controller.text);
                      if (!context.mounted) return;
                      Navigator.of(context).pop();
                    } catch (e) {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed to save selection: $e'),
                          backgroundColor: Theme.of(context).colorScheme.error,
                        ),
                      );
                    }
                  })
            ],
          )),
    );
  }
}
