import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ngam_plan/src/localization/app_localizations.dart';
import 'package:ngam_plan/src/widgets/app_screen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ngam_plan/features/events/cubit/events_cubit.dart';
import 'package:ngam_plan/features/events/models/event.dart';
import 'package:ngam_plan/features/events/models/event_extension.dart';
import 'package:ngam_plan/features/home/widgets/event_home_widget.dart';
import 'package:ngam_plan/src/core/theme/app_colors.dart';
import 'package:ngam_plan/src/widgets/glass_widgets.dart';
import 'package:ngam_plan/src/utils/countdown_calculator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<EventsCubit>().fetchEvents();
  }

  Future<void> _onRefresh() async {
    await context.read<EventsCubit>().fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsCubit, EventsState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: _onRefresh,
          color: Theme.of(context).colorScheme.primary,
          backgroundColor: AppColors.glassSurface,
          child: state.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const _LoadingShimmer(),
              error: (message) => Center(child: Text(message, style: const TextStyle(color: AppColors.error))),
              loaded: (events) {
                //final sortedEvents = List.of(events)..sort((a, b) => a.upcomingDate.compareTo(b.upcomingDate));

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      // Hero Section (Next Event)
                      if (events.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Up Next", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 12),
                              _HeroEventCard(event: _getNextEvent(events)),
                            ],
                          ),
                        ),

                      // All Events List
                      Text("All Events", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),

                      Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 100), // Bottom padding for navbar
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final sortedEvents = _getSortedEvents(events);
                            if (index >= sortedEvents.length) return null;
                            final event = sortedEvents[index];

                            // Skip the first one if it's shown in Hero?
                            // Logic: Show all in list or skip?
                            // "Overview of all events" implies all. I'll show all, maybe mark the first one?
                            // For now, simple list.
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: EventHomeWidget(event: event),
                            ).animate().fadeIn(delay: (50 * index).ms).slideY(begin: 0.1, end: 0);
                          },
                          itemCount: events.length,
                        ),
                      ),
                    ],
                  ),
                );
              }),
        );
      },
    );
  }

  Event _getNextEvent(List<Event> events) {
    final sorted = List.of(events)..sort((a, b) => a.upcomingDate.compareTo(b.upcomingDate));
    return sorted.first;
  }

  List<Event> _getSortedEvents(List<Event> events) {
    return List.of(events)..sort((a, b) => a.upcomingDate.compareTo(b.upcomingDate));
  }
}

class _HeroEventCard extends StatefulWidget {
  final Event event;

  const _HeroEventCard({required this.event});

  @override
  State<_HeroEventCard> createState() => _HeroEventCardState();
}

class _HeroEventCardState extends State<_HeroEventCard> {
  // 3D Tilt State
  Offset _touchPosition = Offset.zero;
  bool _isTouching = false;

  @override
  Widget build(BuildContext context) {
    // Transform logic
    final double rotationX = _isTouching ? (_touchPosition.dy - 100) / 100 * -0.1 : 0; // constrained
    final double rotationY = _isTouching ? (_touchPosition.dx - 150) / 150 * 0.1 : 0;

    return Listener(
      onPointerDown: (details) {
        setState(() {
          _isTouching = true;
          _touchPosition = details.localPosition;
        });
      },
      onPointerMove: (details) {
        setState(() {
          _touchPosition = details.localPosition;
        });
      },
      onPointerUp: (_) => setState(() => _isTouching = false),
      onPointerCancel: (_) => setState(() => _isTouching = false),
      child: TweenAnimationBuilder<Matrix4>(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        tween: Matrix4Tween(
          begin: Matrix4.identity(),
          end: Matrix4.identity()
            ..setEntry(3, 2, 0.001) // Perspective
            ..rotateX(rotationX)
            ..rotateY(rotationY)
            ..scale(_isTouching ? 0.98 : 1.0),
        ),
        builder: (context, matrix, child) {
          return Transform(
            transform: matrix,
            alignment: Alignment.center,
            child: child,
          );
        },
        child: GlassContainer(
          height: 200,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          borderRadius: BorderRadius.circular(24),
          backgroundColor: Theme.of(context).colorScheme.surface, // Highlight for Hero
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(LucideIcons.zap, size: 40, color: Theme.of(context).colorScheme.secondary)
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .scale(begin: const Offset(1, 1), end: const Offset(1.2, 1.2)),
              const SizedBox(height: 16),
              Text(
                widget.event.name,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.glassBorder,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  CountdownCalculator.getCountdownString(widget.event, context),
                  style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadingShimmer extends StatelessWidget {
  const _LoadingShimmer();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Shimmer.fromColors(
            baseColor: Theme.of(context).colorScheme.surface,
            highlightColor: AppColors.glassBorder,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        );
      },
    );
  }
}
