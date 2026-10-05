import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod/riverpod.dart';
import 'package:league_app/features/auth/presentation/screens/login_screen.dart';
import 'package:league_app/features/auth/presentation/screens/register_screen.dart';
import 'package:league_app/features/organizer/presentation/screens/organizer_dashboard.dart';
import 'package:league_app/features/captain/presentation/screens/captain_dashboard.dart';
import 'package:league_app/features/player/presentation/screens/player_dashboard.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/organizer',
        builder: (context, state) => const OrganizerDashboard(),
      ),
      GoRoute(
        path: '/captain',
        builder: (context, state) => const CaptainDashboard(),
      ),
      GoRoute(
        path: '/player',
        builder: (context, state) => const PlayerDashboard(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Text('No route defined for ${state.location}'),
      ),
    ),
  );
});
