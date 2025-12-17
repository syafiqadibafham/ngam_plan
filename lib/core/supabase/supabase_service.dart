import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static Future<void> initialize({required String supabaseUrl, required String anonKey}) async {
    await Supabase.initialize(
      url: supabaseUrl, anonKey: anonKey,
      //publishableKey: supabasePublishableKey,
    );
  }

  SupabaseClient get client => Supabase.instance.client;
}
