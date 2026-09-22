import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/biodata_creator/presentation/biodata_form_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/preview_studio/presentation/preview_studio_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/create-biodata',
        builder: (context, state) => const BiodataFormScreen(),
      ),
      GoRoute(
        path: '/preview-biodata',
        builder: (context, state) => const PreviewStudioScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.uri}'),
      ),
    ),
  );
}
