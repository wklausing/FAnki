import 'dart:io';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:fetch_cards/fetch_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../create_cards/cubit/create_cards_cubit.dart';
import '../create_cards/view/create_cards_page.dart';
import '../learning/cubit/learning_cubit.dart';
import '../learning/view/learning_page.dart';
import '../login/cubit/login_cubit.dart';
import '../login/view/login_page.dart';
import '../manage_decks/cubit/manage_decks_cubit.dart';
import '../manage_decks/view/manage_decks_page.dart';
import 'navigation_cubit.dart';

class FAnkiApp extends StatefulWidget {
  const FAnkiApp({
    super.key,
    required this.authenticationRepository,
    required this.cardDeckManager,
  });

  final AuthenticationRepository authenticationRepository;
  final CardDeckManager cardDeckManager;

  @override
  State<FAnkiApp> createState() => _FAnkiAppState();
}

class _FAnkiAppState extends State<FAnkiApp>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(
              widget.authenticationRepository, widget.cardDeckManager),
        ),
        BlocProvider(
          create: (context) => NavigationCubit(),
        ),
        BlocProvider(
          create: (context) => LearningCubit(
              widget.authenticationRepository, widget.cardDeckManager),
        ),
        BlocProvider(
          create: (context) => CreateCardsCubit(
              repo: widget.authenticationRepository,
              cardDeckManager: widget.cardDeckManager),
        ),
        BlocProvider(
          create: (context) => ManageDecksCubit(
            cardDeckManager: widget.cardDeckManager,
          ),
        ),
      ],
      child: MaterialApp(
        home: StreamBuilder<User>(
          stream: widget.authenticationRepository.user,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            } else if (!snapshot.hasData || snapshot.data == User.empty) {
              return Scaffold(
                body: Center(child: LoginPage()),
              );
            } else {
              return BlocBuilder<NavigationCubit, NavigationState>(
                builder: (context, state) {
                  final mainArea = Expanded(child: _getPage(state));

                  return Platform.isIOS || Platform.isAndroid
                      ? buildMobileNavigationBar(context, mainArea)
                      : buildDesktopNavigationBar(context, mainArea, state);
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildMobileNavigationBar(BuildContext context, Widget mainArea) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          onTap: (int index) {
            _onDestinationSelected(context, index);
          },
          tabs: const [
            Tab(icon: Icon(Icons.school)),
            Tab(icon: Icon(Icons.create)),
            Tab(icon: Icon(Icons.book)),
            Tab(icon: Icon(Icons.login)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          LearningPage(),
          CreateCardsPage(),
          ManageDecksPage(),
          LoginPage(),
        ],
      ),
    );
  }

  Widget buildDesktopNavigationBar(
      BuildContext context, Widget mainArea, NavigationState state) {
    return Scaffold(
      body: Row(
        children: [
          SafeArea(
            child: NavigationRail(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              selectedIndex: _determineSelectedIndex(state),
              onDestinationSelected: (int index) {
                _onDestinationSelected(context, index);
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
          mainArea,
        ],
      ),
    );
  }

  void _onDestinationSelected(BuildContext context, int index) {
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
