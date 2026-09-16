import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'screens/home_screen.dart';
import 'screens/project_detail_screen.dart';
import 'theme/app_theme.dart';
import 'utils/seo.dart';

void main() {
  configureMetaSeo();
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
    if (kIsWeb) {
      applyPortfolioSeo();
    }

    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: portfolioSeoTitle,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.dark,
          routerConfig: _router,
          builder: (context, widget) {
            final media = MediaQuery.of(context);
            return MediaQuery(
              data: media.copyWith(
                textScaler: media.textScaler.clamp(
                  minScaleFactor: 0.9,
                  maxScaleFactor: 1.2,
                ),
              ),
              child: widget ?? const SizedBox.shrink(),
            );
          },
        );
      },
    );
  }
}
