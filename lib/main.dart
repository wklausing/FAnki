import 'dart:io';

import 'package:anki_app/decks_page.dart';
import 'package:anki_app/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  await FirebaseAuth.instance.signOut();

  initializeLogger();
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
  late final Stream<User?> userStream =
      FirebaseAuth.instance.authStateChanges();
  late final TabController _tabController;

  List<Widget> pages = [
    LearningPage(),
    CreateCardsPage(),
    DecksPage(),
    LoginPage(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data == null) {
            return LoginPage();
          } else {
            return buildUserInterface(snapshot.data);
          }
        } else {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  Widget buildUserInterface(User? user) {
    var colorScheme = Theme.of(context).colorScheme;
    var mainArea = ColoredBox(
      color: colorScheme.surfaceVariant,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: pages[_tabController.index],
      ),
    );

    return Platform.isIOS || Platform.isAndroid
        ? buildMobileNavigationBar(mainArea)
        : buildDesktopNavigationBar(mainArea);
  }

  Widget buildMobileNavigationBar(Widget mainArea) {
    return DefaultTabController(
      initialIndex: 3,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            controller: _tabController,
            tabs: const <Widget>[
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
            DecksPage(),
            LoginPage()
          ],
        ),
      ),
    );
  }

  Widget buildDesktopNavigationBar(Widget mainArea) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Row(
            children: [
              SafeArea(
                child: NavigationRail(
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  selectedIndex: _tabController.index,
                  onDestinationSelected: (int index) {
                    setState(() {
                      _tabController.index = index;
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
                child: mainArea,
              ),
            ],
          );
        },
      ),
    );
  }
}
