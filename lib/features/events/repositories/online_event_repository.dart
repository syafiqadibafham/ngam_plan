import 'dart:developer';

import 'package:ngam_plan/features/events/models/event.dart';
import 'package:ngam_plan/features/events/repositories/event_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseEventRepository implements EventRepository {
  final SupabaseClient _supabaseClient;

  SupabaseEventRepository(this._supabaseClient);

  @override
  Future<void> addEvent(Event event) async {
    final user = _supabaseClient.auth.currentUser;
    if (user == null) throw Exception('Not authenticated');

    // final response = await _supabaseClient.from('events').insert({
    //   'name': event.name,
    //   'date': event.date.toUtc().toIso8601String(),
    //   'owner_id': user.id,
    //   'event_type': event.type,
    //   'color': event.colorHex,
    //   'image_url': event.imageUrl,
    // }).select().single();
    final eventMap = event.toJson();
    eventMap['owner_id'] = _supabaseClient.auth.currentUser!.id;
    eventMap.removeWhere((key, value) => key == 'id');

    print("MAp: $eventMap");

    try {
      final response = await _supabaseClient.from('events').insert({
        "name": event.name,
        "start_date": event.startDate.toUtc().toIso8601String(),
        "end_date": event.endDate?.toUtc().toIso8601String(),
        "owner_id": user.id,
        "calculation_type": event.calculationType.toString().split('.').last,
        "image_url": event.imageUrl,
        "color_hex": event.colorHex,
        "event_participants": [],
      });
      print("Response: $response");
    } catch (e) {
      log('Error fetching events: $e');
    }
  }

  @override
  Future<void> deleteEvent(String eventId) async {
    await _supabaseClient.from('events').delete().eq('id', eventId);
  }

  @override
  Future<List<Event>> getEvents() async {
    try {
      final response =
          await _supabaseClient.from('events').select('id, name, start_date, end_date, owner_id, calculation_type, image_url, color_hex, event_participants(*)').order('start_date', ascending: true);
      return (response as List).map((e) => Event.fromJson(e)).toList();
    } catch (e) {
      log('Error fetching events: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateEvent(Event event) async {
    await _supabaseClient.from('events').update(event.toJson()).eq('id', event.id);
  }
}
