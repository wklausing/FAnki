import 'package:fetch_cards/fetch_cards.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'navigation/view/app.dart';
import 'package:authentication_repository/authentication_repository.dart';

final Logger log = Logger('MyAppLogger');

void initializeLogger() {
  log.onRecord.listen((record) {
    if (kDebugMode) {
      print({record.message}); //${record.level.name}: ${record.time}:
    }
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;

  final cardDeckManager = CardDeckManager();

  runApp(
    FAnkiApp(
      authenticationRepository: authenticationRepository,
      cardDeckManager: cardDeckManager,
    ),
  );
}
