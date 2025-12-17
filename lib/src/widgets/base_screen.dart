import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:ngam_plan/src/core/theme/app_icons.dart';
import 'package:ngam_plan/src/widgets/animated_background.dart';
import 'package:ngam_plan/features/events/view/events_view.dart';
import 'package:ngam_plan/features/home/view/home_page.dart';
import 'package:ngam_plan/features/settings/view/settings_page.dart';
import 'package:ngam_plan/src/core/theme/app_colors.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart'; // Updated to use Lucide
import 'package:ngam_plan/src/localization/app_localizations.dart';
import 'package:ngam_plan/src/widgets/navigation_bar.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  static const routeName = '/';

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex = 0;
  late final List<NavBarItem> navbarItems;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    navbarItems = [
      NavBarItem(
        icon: AppIcons.home,
        label: AppLocalizations.of(context)!.homeSectionTitle,
        view: const HomePage(),
      ),
      NavBarItem(
        icon: AppIcons.event,
        label: AppLocalizations.of(context)!.eventsSectionTitle,
        view: const EventsView(),
      ),
      NavBarItem(
        icon: AppIcons.settings,
        label: AppLocalizations.of(context)!.settingsSectionTitle,
        view: const SettingsView(),
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false, // Prevent navbar from being pushed up by keyboard awkwardly (handle in pages)
      body: Stack(
        children: [
          // 1. Animated Gradient Background
          const AnimatedBackground(),

          // 2. Body Content
          SafeArea(
            bottom: false, // Allow content to go behind navbar
            child: IndexedStack(
              index: _selectedIndex,
              children: navbarItems.map((e) => e.view).toList(),
            ),
          ),

          // 3. Floating Glass Navbar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: GlassNavBar(
                items: navbarItems,
                selectedIndex: _selectedIndex,
                onItemTapped: _onItemTapped,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
