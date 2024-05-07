import 'dart:io';

import 'package:anki_app/authentication.dart';
import 'package:anki_app/decks_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:logging/logging.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'create_card_page.dart';
import 'learning_page.dart';
import 'app_state.dart';

final Logger log = Logger('MyAppLogger');

void initializeLogger() {
  log.onRecord.listen((record) {
    if (kDebugMode) {
      print({record.message}); //${record.level.name}: ${record.time}:
    }
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initializeLogger();
  log.info('Logging in');
  await AuthService().signInIfCorrect('foo', 'bar');
  log.info('Starting app');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: 'Anki App',
        theme: ThemeData(
          brightness: Brightness.light,
          useMaterial3: true,
          textTheme: const TextTheme(
            displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            bodyLarge: TextStyle(
              fontSize: 18,
              color: Colors.black87,
            ),
          ),
          appBarTheme: const AppBarTheme(
            color: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.white),
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  late TabController _tabController;

  @override
  initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  List<Widget> pages = [
    LearningPage(),
    CreateCardsPage(),
    DecksPage(),
  ];

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    Widget page = pages[selectedIndex];

    var mainArea = ColoredBox(
      color: colorScheme.surfaceVariant,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: page,
      ),
    );

    Widget navigationBar;
    if (Platform.isIOS || Platform.isAndroid) {
      navigationBar = DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                controller: _tabController,
                tabs: const <Widget>[
                  Tab(
                    icon: Icon(Icons.school),
                  ),
                  Tab(
                    icon: Icon(Icons.create),
                  ),
                  Tab(
                    icon: Icon(Icons.book),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: pages,
            )),
      );
    } else if (Platform.isMacOS) {
      navigationBar = Scaffold(
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Row(
              children: [
                SafeArea(
                  child: NavigationRail(
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    selectedIndex: selectedIndex,
                    onDestinationSelected: (int index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    destinations: [
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
                        label: Text('Placeholder'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: mainArea,
                ),
              ],
            );
          },
        ),
      );
    } else {
      log.severe('Unknown platform.');
      navigationBar = Scaffold();
    }

    return navigationBar;
  }
}
