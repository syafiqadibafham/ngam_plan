import 'package:elegant_nav_bar/elegant_nav_bar.dart';
import 'package:flutter/material.dart';

class NavBarItem {
  final IconData icon;
  final String label;
  final Widget view;

  NavBarItem({required this.icon, required this.label, required this.view});
}

class NavBar extends StatefulWidget {
  const NavBar({super.key, required this.items, required this.selectedIndex, required this.onItemTapped});

  final List<NavBarItem> items;
  final int selectedIndex;
  final Function(int) onItemTapped;

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  Color iconColor(int index) {
    return widget.selectedIndex == index ? Theme.of(context).colorScheme.primary : Theme.of(context).disabledColor;
  }

  @override
  Widget build(BuildContext context) {
    return ElegantBottomNavigationBar(
      onTap: (index) => widget.onItemTapped.call(index),
      currentIndex: widget.selectedIndex,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      indicatorColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Theme.of(context).disabledColor,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      selectedLabelStyle: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),
      unselectedLabelStyle: TextStyle(
        color: Theme.of(context).disabledColor,
      ),
      isFloating: true,
      floatingMargin: EdgeInsets.symmetric(horizontal: 16.0, vertical: MediaQuery.of(context).viewPadding.bottom),
      floatingBorderRadius: 20.0,
      items: widget.items.map((item) {
        return NavigationItem(
          iconWidget: Icon(
            item.icon,
            color: iconColor(widget.items.indexOf(item)),
            size: 20,
          ),
          label: item.label,
        );
      }).toList(),
    );
  }
}
