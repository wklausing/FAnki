import 'package:authentication_repository/authentication_repository.dart';

import 'package:fanki/blocs/authentication/authentication.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FankiApp extends StatefulWidget {
  final GoRouter router;

  const FankiApp({super.key, required this.router});

  @override
  State<FankiApp> createState() => FankiAppState();

  static FankiAppState of(BuildContext context) => context.findAncestorStateOfType<FankiAppState>()!;
}

class FankiAppState extends State<FankiApp> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(
        authenticationRepository: context.read<AuthenticationRepository>(),
      )..add(AuthenticationSubscriptionRequested()),
      child: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          widget.router.refresh();
        },
        child: MaterialApp.router(
          title: 'F/Anki',
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: _themeMode,
          routerConfig: widget.router,
        ),
      ),
    );
  }
}
