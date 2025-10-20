import 'package:flutter/material.dart';
import 'package:ngam_plan/src/localization/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Text(AppLocalizations.of(context)!.homeSectionTitle);
  }
}
