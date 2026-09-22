import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/biodata_creator/presentation/biodata_form_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/invitation_creator/presentation/invitation_form_screen.dart';
import '../../features/preview_studio/presentation/preview_studio_screen.dart';
import '../../features/resume_creator/presentation/resume_form_screen.dart';

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
        path: '/create-invitation',
        builder: (context, state) => const InvitationFormScreen(),
      ),
      GoRoute(
        path: '/create-resume',
        builder: (context, state) => const ResumeFormScreen(),
      ),
      GoRoute(
        path: '/preview-studio',
        builder: (context, state) {
          final category = state.uri.queryParameters['category'];
          return PreviewStudioScreen(initialCategory: category);
        },
      ),
      GoRoute(
        path: '/preview-biodata',
        builder: (context, state) => const PreviewStudioScreen(initialCategory: 'biodata'),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.uri}'),
      ),
    ),
  );
}
