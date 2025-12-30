import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ngam_plan/core/routing/app_routes.dart';
import 'package:ngam_plan/features/events/view/add_event_view.dart';
import 'package:ngam_plan/src/core/theme/app_icons.dart';
import 'package:ngam_plan/features/events/view/events_view.dart';
import 'package:ngam_plan/features/home/view/home_page.dart';
import 'package:ngam_plan/features/settings/view/settings_page.dart';
import 'package:ngam_plan/src/localization/app_localizations.dart';
import 'package:ngam_plan/src/widgets/app_screen.dart';
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
    return AppScreen(
      title: navbarItems[_selectedIndex].label,
      bottomWidget: Column(
        children: [
          if (_selectedIndex == 1)
            Align(
              alignment: Alignment.centerRight,
              child: FloatingActionButton(
                onPressed: () {
                  context.pushNamed(AppRoutes.addEvent.name).then((_) {
                    setState(() {});
                  });
                },
                child: const Icon(AppIcons.add),
              ),
            ), // Extra space when on Events page
          GlassNavBar(
            items: navbarItems,
            selectedIndex: _selectedIndex,
            onItemTapped: _onItemTapped,
          ),
        ],
      ),
      // extendBody: true,
      // resizeToAvoidBottomInset: false, // Prevent navbar from being pushed up by keyboard awkwardly (handle in pages)
      child: IndexedStack(
        index: _selectedIndex,
        children: navbarItems.map((e) => e.view).toList(),
      ),
    );
  }
}
