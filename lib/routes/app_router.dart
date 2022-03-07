import 'dart:async';

import 'package:demo_go_router/app/app_bloc.dart';
import 'package:demo_go_router/pages/home_page.dart';
import 'package:demo_go_router/pages/login_page.dart';
import 'package:demo_go_router/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final Stream<AppState> appStateStream;
  AppRouter(this.appStateStream) {
    appStateStream.listen((event) {
      print('-- app state listen: ${event}');
      if (!event.loading) {
        if (!event.authenticated) {
          router.go('/login');
        } else {
          router.go('/home');
        }
      }
    });
  }

  late final router = GoRouter(
    debugLogDiagnostics: true,
    urlPathStrategy: UrlPathStrategy.path,
    // redirect: (GoRouterState state) {
    //   print('-- AppRouter refresh, full path: ${state.fullpath}');

    //   return null;
    // },

    // refreshListenable: GoRouterRefreshStream(appStateStream),
    routes: [
      GoRoute(
        redirect: (state) {
          return '/login';
        },
        path: '/',
        pageBuilder: (context, state) => MaterialPage(
          child: SplashPage(),
        ),
      ),
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) => MaterialPage(child: LoginPage()),
      ),
      GoRoute(
        path: '/home',
        pageBuilder: (context, state) => MaterialPage(child: HomePage()),
      ),
    ],
  );
}
