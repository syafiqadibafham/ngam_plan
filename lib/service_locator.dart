import 'package:get_it/get_it.dart';
import 'package:ngam_plan/features/events/cubit/events_cubit.dart';
import 'package:ngam_plan/features/events/repositories/event_repository.dart';
import 'package:ngam_plan/features/events/repositories/mock_event_repository.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<EventRepository>(() => MockEventRepository());
  getIt.registerFactory(() => EventsCubit(getIt()));
}
