import 'package:authentication_repository/authentication_repository.dart';
import 'package:fanki/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'pages/deck/deck.dart';
import 'pages/home_tab_view/home_tab_view.dart';
import 'pages/login/login.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginPage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'LoginPage',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginPage();
          },
        ),
        GoRoute(
          name: 'HomeTabView',
          path: '/HomeTabView',
          builder: (BuildContext context, GoRouterState state) {
            return const HomeTabView();
          },
          routes: <RouteBase>[
            GoRoute(
              path: 'DeckPage',
              builder: (BuildContext context, GoRouterState state) {
                return const DeckPage();
              },
            ),
          ],
        ),
      ],
    ),
  ],
  redirect: (context, state) async {
    final status = context.read<AuthenticationBloc>().state.status;
    switch (status) {
      case AuthenticationStatus.authenticated:
        final currentPath = state.fullPath;
        if (currentPath == '/LoginPage' || currentPath == '/') {
          return '/HomeTabView';
        }
        return null;
      case AuthenticationStatus.unauthenticated || AuthenticationStatus.unknown:
        return '/LoginPage';
    }
  },
);
