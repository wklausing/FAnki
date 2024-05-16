import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'learning/learning.dart';
import 'login/view/login_page.dart';
import 'manage_decks/view/manage_decks_page.dart';
import 'navigation_cubit.dart';
import 'create_cards/create_cards.dart';

class FAnkiApp extends StatefulWidget {
  const FAnkiApp({super.key});

  @override
  _FAnkiAppState createState() => _FAnkiAppState();
}

class _FAnkiAppState extends State<FAnkiApp> {
  int _determineSelectedIndex(NavigationState state) {
    int index = -1;
    switch (state) {
      case NavigationState.learning:
        index = 0;
        break;
      case NavigationState.createCards:
        index = 1;
        break;
      case NavigationState.decks:
        index = 2;
        break;
      case NavigationState.login:
        index = 3;
        break;
    }
    return index;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationCubit(),
      child: MaterialApp(
        home: BlocBuilder<NavigationCubit, NavigationState>(
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
                          context.read<NavigationCubit>().goToCreateCards();
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
                  Expanded(
                    child: state == NavigationState.learning
                        ? LearningPage()
                        : state == NavigationState.createCards
                            ? CreateCardsPage()
                            : state == NavigationState.decks
                                ? ManageDecksPage()
                                : LoginPage(),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
