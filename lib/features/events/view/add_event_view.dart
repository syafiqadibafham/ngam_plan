import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ngam_plan/features/events/cubit/events_cubit.dart';
import 'package:ngam_plan/features/events/models/calculation_type_extension.dart';
import 'package:ngam_plan/features/events/models/event.dart';
import 'package:ngam_plan/features/events/models/calculation_types.dart';
import 'package:ngam_plan/src/core/theme/app_colors.dart';
import 'package:ngam_plan/src/widgets/app_screen.dart';
import 'package:ngam_plan/src/widgets/text_input.dart';

class AddEventSheet extends StatefulWidget {
  const AddEventSheet({super.key});

  @override
  State<AddEventSheet> createState() => _AddEventSheetState();
}

class _AddEventSheetState extends State<AddEventSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  DateTime? _selectedDate;
  CalculationType _selectedType = CalculationType.general;
  File? _imageFile;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _saveEvent() {
    if (_formKey.currentState!.validate()) {
      if (_selectedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please choose a date')),
        );
        return;
      }
      final newEvent = Event(
        id: UniqueKey().toString(),
        name: _nameController.text,
        date: _selectedDate!,
        calculationType: _selectedType,
        imageUrl: _imageFile?.path,
      );
      context.read<EventsCubit>().addEvent(newEvent).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add event: $error')),
        );
      }).then((_) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Event added successfully')),
        );
        Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      title: "Add New Event",
      bottomWidget: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ElevatedButton(
            onPressed: _saveEvent,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Save Event'),
          ),
        ),
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImagePicker(),
              const SizedBox(height: 16),
              _buildEventTypeSelector(),
              const SizedBox(height: 16),
              TextInput(
                controller: _nameController,
                labelText: 'Event Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an event name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildDatePicker(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    return Center(
      child: GestureDetector(
        onTap: _pickImage,
        child: Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            color: AppColors.glassSurface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.glassBorder, width: 1),
            image: _imageFile != null
                ? DecorationImage(
                    image: FileImage(_imageFile!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: _imageFile == null
              ? const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_a_photo_outlined, size: 40, color: AppColors.textSecondary),
                    SizedBox(height: 8),
                    Text('Add Image', style: TextStyle(color: AppColors.textSecondary)),
                  ],
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.glassSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _selectedDate == null ? 'No date chosen' : 'Date: ${_selectedDate!.toLocal().toString().split(' ')[0]}',
            style: const TextStyle(color: AppColors.textPrimary),
          ),
          TextButton(
            onPressed: () async {
              final pickedDate = await showDatePicker(
                context: context,
                initialDate: _selectedDate ?? DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: _selectedType.lastDate,
              );
              if (pickedDate != null) {
                setState(() {
                  _selectedDate = pickedDate;
                });
              }
            },
            child: const Text('Choose Date'),
          ),
        ],
      ),
    );
  }

  Widget _buildEventTypeSelector() {
    return DropdownButtonFormField<CalculationType>(
      value: _selectedType,
      onChanged: (CalculationType? newValue) {
        if (newValue != null) {
          setState(() {
            _selectedType = newValue;
          });
        }
      },
      items: CalculationType.values.map((CalculationType type) {
        return DropdownMenuItem<CalculationType>(
          value: type,
          child: Text(type.name[0].toUpperCase() + type.name.substring(1)),
        );
      }).toList(),
      decoration: const InputDecoration(
        labelText: 'Event Type',
        border: OutlineInputBorder(),
      ),
    );
  }
}
