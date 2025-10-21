import 'package:flutter/material.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({
    super.key,
    required this.title,
    required this.child,
    this.floatingActionButton,
    this.bottomWidget,
  });

  final String title;
  final Widget child;
  final Widget? floatingActionButton;
  final Widget? bottomWidget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      //floatingActionButton: floatingActionButton,
      body: Stack(
        children: [
          SizedBox(height: double.infinity, child: child),
          if (bottomWidget != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: bottomWidget!,
            ),
          if (floatingActionButton != null)
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.12,
              right: 15,
              child: floatingActionButton!,
            ),
        ],
      ),
      //bottomNavigationBar: bottomWidget,
    );
  }
}
