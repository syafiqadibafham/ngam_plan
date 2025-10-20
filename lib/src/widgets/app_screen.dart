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
        title: Text(title),
      ),
      floatingActionButton: floatingActionButton,
      body: child,
    );
  }
}
