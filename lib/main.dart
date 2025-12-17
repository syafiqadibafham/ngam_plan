import 'package:flutter/material.dart';
import 'package:ngam_plan/core/config.dart';
import 'package:ngam_plan/core/supabase/supabase_service.dart';
import 'package:ngam_plan/service_locator.dart';

import 'src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseService.initialize(
    supabaseUrl: AppConfig.supabaseUrl,
    anonKey: AppConfig.supabasePublishableKey,
  );
  setup();
  runApp(const MyApp());
}
