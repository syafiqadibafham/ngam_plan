import 'package:flutter/material.dart';
import 'package:ngam_plan/src/core/theme/app_colors.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({
    super.key,
    required this.title,
    required this.child,
    this.floatingActionButton,
    this.bottomWidget,
    this.includeBackground = false,
  });

  final String title;
  final Widget child;
  final Widget? floatingActionButton;
  final Widget? bottomWidget;
  final bool includeBackground;

  @override
  Widget build(BuildContext context) {
    Widget content = Stack(
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
    );

    // if (includeBackground) {
    //   content = AnimatedBackground(child: content);
    // }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.backgroundStart,
            Theme.of(context).scaffoldBackgroundColor,
            Theme.of(context).scaffoldBackgroundColor,
            AppColors.backgroundEnd,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0.0, 0.25, 0.75, 1.0],
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: false,
          title: Text(
            title,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        //floatingActionButton: floatingActionButton,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: content,
        ),
        //bottomNavigationBar: bottomWidget,
      ),
    );
  }
}
