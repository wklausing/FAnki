import 'package:authentication_repository/authentication_repository.dart';
import 'package:deck_repository/deck_repository.dart';
import 'package:user_repository/user_repository.dart';

import 'package:fanki/blocs/authentication/authentication.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MyApp extends StatefulWidget {
  final GoRouter router;

  const MyApp({super.key, required this.router});

  @override
  State<MyApp> createState() => MyAppState();

  static MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<MyAppState>()!;
}

class MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;
  late final AuthenticationRepository _authenticationRepository;
  late final UserRepository _userRepository;
  late final DeckRepository _deckRepository;

  @override
  void initState() {
    super.initState();
    _authenticationRepository = AuthenticationRepository();
    _userRepository = UserRepository();
    _deckRepository = DeckRepository(foo: true);
  }

  @override
  void dispose() {
    _authenticationRepository.dispose();
    super.dispose();
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>.value(
          value: _authenticationRepository,
        ),
        RepositoryProvider<DeckRepository>.value(
          value: _deckRepository,
        ),
      ],
      child: BlocProvider(
        create: (context) => AuthenticationBloc(
          authenticationRepository: _authenticationRepository,
          userRepository: _userRepository,
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
      ),
    );
  }
}
