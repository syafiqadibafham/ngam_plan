import 'package:flutter/material.dart';
import 'package:ngam_plan/features/events/view/events_view.dart';
import 'package:ngam_plan/features/home/view/home_screen.dart';
import 'package:ngam_plan/features/settings/view/settings_view.dart';
import 'package:ngam_plan/src/core/theme/app_icons.dart';
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
        view: const HomeScreen(),
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
      body: navbarItems[_selectedIndex].view,
      bottomNavigationBar: NavBar(
        items: navbarItems,
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
