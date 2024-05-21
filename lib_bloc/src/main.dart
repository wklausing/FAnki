import 'package:fetch_cards/fetch_cards.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'package:authentication_repository/authentication_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;

  final cardDeckManager = CardDeckManager();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authenticationRepository),
        RepositoryProvider.value(value: cardDeckManager),
      ],
      child: FAnkiApp(
        authenticationRepository: authenticationRepository,
        cardDeckManager: cardDeckManager,
      ),
    ),
  );
}
