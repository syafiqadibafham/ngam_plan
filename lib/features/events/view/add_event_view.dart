import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngam_plan/features/events/cubit/events_cubit.dart';
import 'package:ngam_plan/features/events/models/event.dart';
import 'package:ngam_plan/features/events/models/event_types.dart';
import 'package:ngam_plan/src/core/theme/app_typography.dart';
import 'package:ngam_plan/src/widgets/app_screen.dart';

class AddEventView extends StatefulWidget {
  const AddEventView({super.key});

  static const routeName = '/add-event';

  @override
  State<AddEventView> createState() => _AddEventViewState();
}

class _AddEventViewState extends State<AddEventView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  DateTime? _selectedDate;
  // TODO: Add image and event type variables

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      title: 'Add Event',
      bottomWidget: Padding(
        padding: const EdgeInsets.all(20.0),
        child: InkWell(
          onTap: () {
            if (_formKey.currentState!.validate()) {
              if (_selectedDate == null) {
                // Show an error if no date is selected
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please choose a date')),
                );
                return;
              }
              final newEvent = Event(
                id: UniqueKey().toString(),
                name: _nameController.text,
                date: _selectedDate!,
                type: EventType.general,
              );
              context.read<EventsCubit>().addEvent(newEvent).then((_) {
                if (!mounted) return;

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Event added successfully')),
                );
                Navigator.of(context).pop();
              }).catchError((error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to add event: $error')),
                );
              });
            }
          },
          child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(child: Text('Save Event', style: Theme.of(context).textTheme.labelLarge!.withColor(Theme.of(context).colorScheme.onPrimary)))),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Event Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an event name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Date Picker
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null ? 'No date chosen' : 'Date: ${_selectedDate!.toLocal()}',
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _selectedDate = pickedDate;
                        });
                      }
                    },
                    child: const Text('Choose Date:'),
                  ),
                ],
              ),
              // TODO: Add Image Picker and Event Type Dropdown
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
