import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'learning/learning.dart';
import 'login/cubit/login_cubit.dart';
import 'login/view/login_page.dart';
import 'manage_decks/view/manage_decks_page.dart';
import 'navigation_cubit.dart';
import 'create_cards/create_cards.dart';

class FAnkiApp extends StatefulWidget {
  const FAnkiApp(
      {super.key, required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository;

  final AuthenticationRepository _authenticationRepository;

  @override
  State<FAnkiApp> createState() => _FAnkiAppState();
}

class _FAnkiAppState extends State<FAnkiApp> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: widget._authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginCubit(widget._authenticationRepository),
          ),
          BlocProvider(
            create: (context) => NavigationCubit(),
          ),
          BlocProvider(
            create: (context) =>
                LearningCubit(widget._authenticationRepository),
          ),
        ],
        child: MaterialApp(
          home: StreamBuilder<User>(
            stream: widget._authenticationRepository.user,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }
              if (!snapshot.hasData || snapshot.data == User.empty) {
                return Scaffold(
                  body: Center(child: LoginPage()),
                );
              }
              return BlocBuilder<NavigationCubit, NavigationState>(
                builder: (context, state) {
                  return Scaffold(
                    body: Row(
                      children: [
                        SafeArea(
                          child: NavigationRail(
                            backgroundColor:
                                Theme.of(context).colorScheme.primaryContainer,
                            selectedIndex: _determineSelectedIndex(state),
                            onDestinationSelected: (int index) {
                              if (index == 0) {
                                context.read<NavigationCubit>().goToLearning();
                              } else if (index == 1) {
                                context
                                    .read<NavigationCubit>()
                                    .goToCreateCards();
                              } else if (index == 2) {
                                context.read<NavigationCubit>().goToDecks();
                              } else if (index == 3) {
                                context.read<NavigationCubit>().goToLogin();
                              } else {
                                throw UnimplementedError();
                              }
                            },
                            destinations: const [
                              NavigationRailDestination(
                                icon: Icon(Icons.school_outlined),
                                selectedIcon: Icon(Icons.school),
                                label: Text('Learning'),
                              ),
                              NavigationRailDestination(
                                icon: Icon(Icons.create_outlined),
                                selectedIcon: Icon(Icons.create),
                                label: Text('Creating cards'),
                              ),
                              NavigationRailDestination(
                                icon: Icon(Icons.book_outlined),
                                selectedIcon: Icon(Icons.book),
                                label: Text('Decks'),
                              ),
                              NavigationRailDestination(
                                icon: Icon(Icons.login_outlined),
                                selectedIcon: Icon(Icons.login),
                                label: Text('Login'),
                              ),
                            ],
                          ),
                        ),
                        Expanded(child: _getPage(state))
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  int _determineSelectedIndex(NavigationState state) {
    switch (state) {
      case NavigationState.learning:
        return 0;
      case NavigationState.createCards:
        return 1;
      case NavigationState.decks:
        return 2;
      case NavigationState.login:
        return 3;
      default:
        return -1;
    }
  }

  Widget _getPage(NavigationState state) {
    switch (state) {
      case NavigationState.learning:
        return LearningPage();
      case NavigationState.createCards:
        return CreateCardsPage();
      case NavigationState.decks:
        return ManageDecksPage();
      case NavigationState.login:
      default:
        return LoginPage();
    }
  }
}
