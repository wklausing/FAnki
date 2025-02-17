import 'package:deck_repository/deck_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'deck_selection/deck_selection.dart';
import 'settings/settings.dart';

class HomeTabView extends StatefulWidget {
  const HomeTabView({Key? key}) : super(key: key);

  @override
  State<HomeTabView> createState() => _HomeTabViewState();
}

class _HomeTabViewState extends State<HomeTabView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DeckSelectionBloc(deckRepository: context.read<DeckRepository>())
            ..add(FetchDecks()),
      child: Scaffold(
        appBar: AppBar(
          title: tabController.index == 0
              ? Text('Deck Selection')
              : Text('Settings'),
          centerTitle: true,
          automaticallyImplyLeading: false,
          bottom: TabBar(
            controller: tabController,
            tabs: const [
              Tab(icon: Icon(Icons.school)),
              Tab(icon: Icon(Icons.settings)),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            DeckSelectionPage(),
            SettingsPage(),
          ],
        ),
      ),
    );
  }
}
