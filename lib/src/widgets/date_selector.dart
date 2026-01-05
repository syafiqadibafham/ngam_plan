import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:ngam_plan/features/events/models/calculation_type_extension.dart';
import 'package:ngam_plan/features/events/models/calculation_types.dart';
import 'package:ngam_plan/src/widgets/text_card.dart';

class DateSelector extends StatelessWidget {
  const DateSelector({super.key, required this.label, required this.selectedDate, required this.selectedCalculationType, this.onDateChanged});

  final String label;
  final DateTime? selectedDate;
  final CalculationType selectedCalculationType;
  final Function(DateTime date)? onDateChanged;

  @override
  Widget build(BuildContext context) {
    return TextCard(
      title: label,
      subtitle: selectedDate == null ? 'No date chosen' : Jiffy.parseFromDateTime(selectedDate!.toLocal()).format(pattern: "dd MMM yyyy"),
      actionLabel: 'Choose Date',
      onActionPressed: () async {
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: selectedCalculationType.lastDate,
        );
        if (pickedDate != null) {
          onDateChanged?.call(pickedDate);
        }
      },
    );

    //   Container(
    //     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    //     decoration: BoxDecoration(
    //       color: AppColors.glassSurface,
    //       borderRadius: BorderRadius.circular(12),
    //       border: Border.all(color: AppColors.glassBorder),
    //     ),
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Text(
    //           selectedDate == null ? 'No date chosen' : 'Date: ${selectedDate!.toLocal().toString().split(' ')[0]}',
    //           style: const TextStyle(color: AppColors.textPrimary),
    //         ),
    //         TextButton(
    //           onPressed: () async {
    //             final pickedDate = await showDatePicker(
    //               context: context,
    //               initialDate: selectedDate ?? DateTime.now(),
    //               firstDate: DateTime(1900),
    //               lastDate: selectedCalculationType.lastDate,
    //             );
    //             if (pickedDate != null) {
    //               onDateChanged?.call(pickedDate);
    //             }
    //           },
    //           child: const Text('Choose Date'),
    //         ),
    //       ],
    //     ),
    //   );
  }
}
