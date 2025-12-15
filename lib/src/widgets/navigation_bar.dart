import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:ngam_plan/src/core/theme/app_colors.dart';
import 'package:ngam_plan/src/widgets/glass_widgets.dart';

class NavBarItem {
  final IconData icon;
  final String label;
  final Widget view;

  NavBarItem({required this.icon, required this.label, required this.view});
}

class GlassNavBar extends StatelessWidget {
  const GlassNavBar({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  final List<NavBarItem> items;
  final int selectedIndex;
  final Function(int) onItemTapped;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      height: 70,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      borderRadius: BorderRadius.circular(35),
      blur: 20,
      backgroundColor: AppColors.glassSurface.withOpacity(0.15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isSelected = index == selectedIndex;
          
          return GestureDetector(
            onTap: () => onItemTapped(index),
            behavior: HitTestBehavior.opaque,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated Icon
                Icon(
                  item.icon,
                  size: 24,
                  color: isSelected ? AppColors.accentStart : AppColors.textDisabled,
                )
                .animate(target: isSelected ? 1 : 0)
                .scale(end: const Offset(1.2, 1.2), duration: 200.ms, curve: Curves.easeOutBack)
                .elevation(end: 10, color: AppColors.accentStart.withOpacity(0.5))
                .effect(duration: 300.ms, curve: Curves.easeInOut), // Generic effect holder for ensuring animation triggers
                
                const SizedBox(height: 4),
                
                // Label (Optional: only show when selected?)
                // Design choice: Show all but fade unselected? Or simple dot?
                // Request said "Airbnb" style which usually has labels.
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 10,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected ? AppColors.accentStart : AppColors.textDisabled,
                  ),
                  child: Text(item.label),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
