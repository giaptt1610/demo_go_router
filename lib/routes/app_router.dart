import 'dart:async';

import 'package:demo_go_router/models/product.dart';
import 'package:demo_go_router/pages/details_page.dart';
import 'package:demo_go_router/pages/error_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../blocs/app/app_bloc.dart';
import '../pages/cart_page.dart';
import '../pages/home_page.dart';
import '../pages/login_page.dart';
import '../pages/shop_page.dart';
import '../pages/splash_page.dart';

class AppRouter {
  final Stream<AppState> appStateStream;
  AppState? _currentState;

  AppRouter(this.appStateStream) {
    appStateStream.listen((event) {
      _currentState = event;
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
    // refreshListenable: GoRouterRefreshStream(appStateStream),
    errorPageBuilder: (context, state) => MaterialPage<void>(
      key: state.pageKey,
      child: ErrorPage(error: state.error),
    ),
    routes: [
      GoRoute(
        redirect: (state) {
          return '/login';
        },
        path: '/',
        pageBuilder: (context, state) => MaterialPage(
          child: SplashPage(),
        ),
        builder: (context, state) => SplashPage(),
      ),
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) => MaterialPage(child: LoginPage()),
      ),
      GoRoute(
        path: '/home',
        pageBuilder: (context, state) => MaterialPage(child: HomePage()),
      ),
      GoRoute(
        path: '/shop',
        name: '/shop',
        pageBuilder: (context, state) {
          return MaterialPage(child: ShopPage());
        },
        routes: [
          GoRoute(
            name: 'product',
            path: ':productId',
            pageBuilder: (context, state) {
              String productId = state.params['productId'] ?? '';
              return MaterialPage(
                  child: DetailsPage(
                productId: productId,
              ));
            },
          ),
        ],
      ),
      GoRoute(
        path: '/cart',
        pageBuilder: (context, state) => MaterialPage(child: CartPage()),
      ),
      GoRoute(
        path: '/product-detail',
        pageBuilder: (context, state) {
          final product =
              (state.extra as Map<String, dynamic>)['item'] as Product;
          return MaterialPage(child: DetailsPage(product: product));
        },
      ),
    ],
  );
}
