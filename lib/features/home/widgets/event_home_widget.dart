import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ngam_plan/features/events/models/event.dart';
import 'package:ngam_plan/features/events/models/event_extension.dart';
import 'package:ngam_plan/src/core/theme/app_colors.dart';
import 'package:ngam_plan/src/utils/countdown_calculator.dart';
import 'package:ngam_plan/src/widgets/glass_widgets.dart';

class EventHomeWidget extends StatelessWidget {
  const EventHomeWidget({super.key, required this.event, this.onTap});

  final Event event;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        padding: const EdgeInsets.all(12),
        borderRadius: BorderRadius.circular(16),
        child: Row(
          children: [
            // Event Image
            Hero(
              tag: 'event_image_${event.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: event.imageUrl != null && event.imageUrl!.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: event.imageUrl!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(color: AppColors.glassSurface),
                          errorWidget: (context, url, error) => const Icon(LucideIcons.image, color: AppColors.textDisabled),
                        )
                      : Container(
                          color: AppColors.glassSurface,
                          child: Icon(LucideIcons.calendar, color: AppColors.textDisabled),
                        ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            
            // Event Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    event.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  
                  // Date
                  Row(
                    children: [
                      Icon(LucideIcons.calendarClock, size: 14, color: AppColors.secondary),
                      const SizedBox(width: 4),
                      Text(
                        event.upcomingDate.toLocal().toString().split(' ')[0], // Simple date format
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  
                  // Countdown
                  Row(
                    children: [
                      Icon(LucideIcons.hourglass, size: 14, color: AppColors.accentStart),
                      const SizedBox(width: 4),
                      Text(
                        CountdownCalculator.getCountdownString(event, context),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.accentStart,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Arrow
            Icon(LucideIcons.chevronRight, color: AppColors.textDisabled, size: 20),
          ],
        ),
      ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.1, end: 0),
    );
  }
}
