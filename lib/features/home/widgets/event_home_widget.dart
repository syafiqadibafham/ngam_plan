import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:jiffy/jiffy.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ngam_plan/core/routing/app_routes.dart';
import 'package:ngam_plan/features/events/models/event.dart';
import 'package:ngam_plan/features/events/models/event_extension.dart';
import 'package:ngam_plan/src/core/theme/app_colors.dart';
import 'package:ngam_plan/src/utils/countdown_calculator.dart';

class EventHomeWidget extends StatelessWidget {
  const EventHomeWidget({super.key, required this.event, this.onTap});

  final Event event;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final countdown = CountdownCalculator.getCountdown(event, context);
    return GestureDetector(
      onTap: () {
        onTap?.call();
        context.pushNamed(AppRoutes.event.name, pathParameters: {'id': event.id});
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.glassBorder),
        ),
        //elevation: 0,
        // padding: const EdgeInsets.all(12),
        // borderRadius: BorderRadius.circular(16),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurface,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
              ),
              width: 50,
              height: 70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(event.upcomingDate.day.toString(),
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.surface,
                          )),
                  Text(
                    Jiffy.parseFromDateTime(event.upcomingDate).MMM,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                  ),
                ],
              ),
            ),
            // Event Image
            // Hero(
            //   tag: 'event_image_${event.id}',
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.circular(12),
            //     child: Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 10.0),
            //       child: event.imageUrl != null && event.imageUrl!.isNotEmpty
            //           ? CachedNetworkImage(
            //               imageUrl: event.imageUrl!,
            //               fit: BoxFit.cover,
            //               placeholder: (context, url) => Container(color: AppColors.glassSurface),
            //               errorWidget: (context, url, error) => const Icon(LucideIcons.image, color: AppColors.textDisabled),
            //             )
            //           : Container(
            //               color: AppColors.glassSurface,
            //               child: Icon(AppIcons.event, color: Theme.of(context).colorScheme.onSurface),
            //             ),
            //     ),
            //   ),
            // ),
            const SizedBox(width: 16),

            // Event Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                    // const SizedBox(height: 6),

                    // // Date
                    // Row(
                    //   children: [
                    //     Icon(LucideIcons.calendarClock, size: 14, color: Theme.of(context).disabledColor),
                    //     const SizedBox(width: 4),
                    //     Text(
                    //       event.upcomingDate.toLocal().toString().split(' ')[0], // Simple date format
                    //       style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).disabledColor),
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(height: 4),

                    // Countdown
                    Row(
                      children: [
                        Icon(LucideIcons.hourglass, size: 14, color: Theme.of(context).colorScheme.primary),
                        const SizedBox(width: 4),
                        Text(
                          countdown.milestoneLabel,
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Arrow
            Icon(LucideIcons.chevronRight, color: Theme.of(context).disabledColor, size: 20),
            const SizedBox(width: 8),
          ],
        ),
      ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.1, end: 0),
    );
  }
}
