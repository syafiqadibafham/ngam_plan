import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ngam_plan/features/events/models/event.dart';
import 'package:ngam_plan/src/core/theme/app_icons.dart';
import 'package:ngam_plan/src/core/theme/app_typography.dart';
import 'package:ngam_plan/src/utils/countdown_calculator.dart';

class EventHomeWidget extends StatelessWidget {
  const EventHomeWidget({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Stack(
        alignment: AlignmentGeometry.centerLeft,
        children: [
          _Image(event.imageUrl),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.name,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      _TextWithIcon(
                        CountdownCalculator.getCountdownString(event, context),
                        icon: AppIcons.timer,
                      ),
                      _TextWithIcon(
                        CountdownCalculator.getNextMilestoneDate(event).toLocal().toString().split(' ')[0],
                        icon: AppIcons.event,
                        color: Theme.of(context).colorScheme.onSecondary.withAlpha(100),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image(this.imageUrl);

  final String? imageUrl;

  bool get hasImage => imageUrl != null && imageUrl!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(child: SizedBox()),
          AspectRatio(
            aspectRatio: 3 / 2,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: hasImage
                        ? CachedNetworkImage(
                            alignment: Alignment.centerRight,
                            imageUrl: imageUrl!,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(color: Theme.of(context).colorScheme.error.withAlpha(100)),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          )
                        : const SizedBox(),
                  ),
                ),
                if (hasImage)
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Theme.of(context).colorScheme.secondary,
                          Theme.of(context).colorScheme.secondary.withAlpha(60),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TextWithIcon extends StatelessWidget {
  const _TextWithIcon(this.text, {required this.icon, this.color});

  final String text;
  final IconData icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: color ?? Theme.of(context).colorScheme.onSecondary,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium!.withColor(
                color ?? Theme.of(context).colorScheme.onSecondary,
              ),
        )
      ],
    );
  }
}
