import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ngam_plan/core/routing/app_routes.dart';
import 'package:ngam_plan/features/auth/cubit/auth_cubit.dart';
import 'package:ngam_plan/features/auth/view/login_page.dart';
import 'package:ngam_plan/features/auth/view/register_page.dart';
import 'package:ngam_plan/features/events/view/add_event_view.dart';
import 'package:ngam_plan/features/events/view/events_view.dart';
import 'package:ngam_plan/features/settings/view/settings_page.dart';
import 'package:ngam_plan/features/settings/view/update_profile_page.dart';
import 'package:ngam_plan/src/widgets/base_screen.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class AppRouter {
  final AuthCubit authCubit;

  AppRouter(this.authCubit);

  late final GoRouter router = GoRouter(
    refreshListenable: GoRouterRefreshStream(authCubit.stream),
    initialLocation: AppRoutes.home.path,
    routes: [
      GoRoute(
        name: AppRoutes.home.name,
        path: AppRoutes.home.path,
        builder: (context, state) => const BaseScreen(),
        routes: [
          GoRoute(name: AppRoutes.events.name, path: AppRoutes.events.path, builder: (context, state) => const EventsView(), routes: [
            GoRoute(
              name: AppRoutes.addEvent.name,
              path: AppRoutes.addEvent.path,
              pageBuilder: (context, state) {
                // Use ModalSheetPage to show a modal sheet with Navigator 2.0.
                // It works with any *Sheet provided by this package!
                return ModalSheetPage(
                  key: state.pageKey,
                  // Enable the swipe-to-dismiss behavior.
                  swipeDismissible: true,
                  // Use `SwipeDismissSensitivity` to tweak the sensitivity of the swipe-to-dismiss behavior.
                  swipeDismissSensitivity: const SwipeDismissSensitivity(
                    minFlingVelocityRatio: 2.0,
                    dismissalOffset: SheetOffset.proportionalToViewport(0.4),
                  ),
                  // You don't need a SheetViewport for the modal sheet.
                  child: const AddEventPage(),
                );
              },
            ),
          ]),
          GoRoute(
            name: AppRoutes.settings.name,
            path: AppRoutes.settings.path,
            builder: (context, state) => const SettingsView(),
            routes: [
              GoRoute(
                name: AppRoutes.updateProfile.name,
                path: AppRoutes.updateProfile.path,
                builder: (context, state) => const UpdateProfilePage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        name: AppRoutes.login.name,
        path: AppRoutes.login.path,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        name: AppRoutes.register.name,
        path: AppRoutes.register.path,
        builder: (context, state) => const RegisterView(),
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final bool loggedIn = authCubit.state.status == AuthStatus.authenticated;
      final bool loggingIn = state.matchedLocation == AppRoutes.login.path || state.matchedLocation == AppRoutes.register.path;

      if (!loggedIn) {
        return loggingIn ? null : AppRoutes.login.path;
      }

      if (loggingIn) {
        return '/';
      }

      return null;
    },
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
