import 'package:flutter/material.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({super.key, required this.title, required this.child, this.floatingActionButton});

  final String title;
  final Widget child;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      //floatingActionButton: floatingActionButton,
      body: Stack(
        children: [
          child,
          if (floatingActionButton != null)
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.12,
              right: 15,
              child: floatingActionButton!,
            ),
        ],
      ),
    );
  }
}
