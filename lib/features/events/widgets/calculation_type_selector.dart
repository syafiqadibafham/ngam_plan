import 'package:flutter/material.dart';
import 'package:ngam_plan/features/events/models/calculation_types.dart';
import 'package:ngam_plan/src/core/theme/app_ui.dart';
import 'package:ngam_plan/src/localization/app_localizations.dart';
import 'package:ngam_plan/src/widgets/button.dart';
import 'package:ngam_plan/src/widgets/text_card.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class CalculationTypeSelector extends StatelessWidget {
  const CalculationTypeSelector({super.key, required this.selectedCalculationType, required this.onDone});

  final CalculationType selectedCalculationType;
  final Function(CalculationType type) onDone;

  @override
  Widget build(BuildContext context) {
    return TextCard(
        title: AppLocalizations.of(context)!.calculationType,
        subtitle: selectedCalculationType.name[0].toUpperCase() + selectedCalculationType.name.substring(1),
        actionLabel: AppLocalizations.of(context)!.change,
        onActionPressed: () {
          AppHelpers.showBottomSheet(context, child: _CalculationTypeSheet(value: selectedCalculationType, onDone: onDone));
        });
  }
}

class _CalculationTypeSheet extends StatefulWidget {
  _CalculationTypeSheet({this.value, required this.onDone});

  final CalculationType? value;
  final Function(CalculationType type) onDone;

  @override
  State<_CalculationTypeSheet> createState() => _CalculationTypeSheetState();
}

class _CalculationTypeSheetState extends State<_CalculationTypeSheet> {
  final ValueNotifier<CalculationType> selectedTypeNotifier = ValueNotifier<CalculationType>(CalculationType.general);

  @override
  void initState() {
    super.initState();
    if (widget.value != null) {
      selectedTypeNotifier.value = widget.value!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Sheet(
      decoration: MaterialSheetDecoration(
        size: SheetSize.fit,
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
      ),
      child: ValueListenableBuilder(
          valueListenable: selectedTypeNotifier,
          builder: (context, value, child) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      AppLocalizations.of(context)!.selectItem(AppLocalizations.of(context)!.calculationType.toLowerCase()),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ...CalculationType.values.map((type) {
                    final isSelected = value == type;
                    return ListTile(
                      selected: isSelected,
                      selectedColor: Theme.of(context).colorScheme.primary,
                      tileColor: Theme.of(context).cardColor,
                      leading: Text(type.emoji),
                      titleTextStyle: isSelected
                          ? TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            )
                          : TextStyle(
                              color: Theme.of(context).textTheme.titleLarge?.color,
                              fontWeight: FontWeight.normal,
                            ),
                      title: Text(type.name[0].toUpperCase() + type.name.substring(1)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: isSelected ? Theme.of(context).colorScheme.primary : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      onTap: () {
                        selectedTypeNotifier.value = type;
                      },
                    );
                  }),
                  Button(
                      label: AppLocalizations.of(context)!.done,
                      onPressed: () {
                        try {
                          widget.onDone(value);
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
              ),
            );
          }),
    );
  }
}
