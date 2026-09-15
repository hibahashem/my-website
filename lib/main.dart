import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'screens/home_screen.dart';
import 'screens/project_detail_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const PortfolioApp());
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/projects/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ProjectDetailScreen(projectId: id);
      },
    ),
  ],
);

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Hiba Hashem — Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      routerConfig: _router,
    );
  }
}
