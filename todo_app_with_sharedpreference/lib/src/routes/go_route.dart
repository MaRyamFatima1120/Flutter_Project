import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app_with_sharedpreference/src/routes/transition_routes.dart';
import 'package:todo_app_with_sharedpreference/src/view/main_page.dart';
import '../view/splash_page.dart';
import 'error_route.dart';


class MyAppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        name: AppRoute.errorPage,
        path: '/error-page',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const ErrorPage(),
        ),
      ),
      GoRoute(
        name: AppRoute.splashPage,
        path: '/',
        pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
          context: context,
          state: state,
          child: const SplashPage(),
        ),
      ),
      GoRoute(
        name: AppRoute.mainPage,
        path: '/main',
        pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
          context: context,
          state: state,
          child: const MainPage(),
        ),
      ),

    ],
    errorPageBuilder: (context, state) {
      return const MaterialPage(child: ErrorPage());
    },
  );
}

class AppRoute {
  static const String errorPage = 'error-page';
  static const String splashPage = 'splash-page';
  static const String mainPage = 'main-page';
}
