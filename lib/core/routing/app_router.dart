import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ngam_plan/features/auth/cubit/auth_cubit.dart';
import 'package:ngam_plan/features/auth/view/login_page.dart';
import 'package:ngam_plan/features/auth/view/register_page.dart';
import 'package:ngam_plan/features/settings/view/settings_page.dart';
import 'package:ngam_plan/features/settings/view/update_profile_page.dart';
import 'package:ngam_plan/src/widgets/base_screen.dart';

class AppRouter {
  final AuthCubit authCubit;

  AppRouter(this.authCubit);

  late final GoRouter router = GoRouter(
    refreshListenable: GoRouterRefreshStream(authCubit.stream),
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const BaseScreen(),
        routes: [
          GoRoute(
            path: 'settings',
            builder: (context, state) => const SettingsView(),
            routes: [
              GoRoute(
                path: 'update-profile',
                builder: (context, state) => const UpdateProfilePage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterView(),
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final bool loggedIn = authCubit.state.status == AuthStatus.authenticated;
      final bool loggingIn = state.matchedLocation == '/login' || state.matchedLocation == '/register';

      if (!loggedIn) {
        return loggingIn ? null : '/login';
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
