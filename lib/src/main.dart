import 'package:http/http.dart';
import 'package:fetch_cards/fetch_cards.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'navigation/view/app.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

final Logger log = Logger('MyAppLogger');

void initializeLogger() {
  log.onRecord.listen((record) {
    if (kDebugMode) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    }
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;

  final cardDeckManager = CardDeckManager();

  var gemini = GenerativeModel(
    model: 'gemini-pro',
    apiKey: '',
    httpClient: VertexHttpClient(
        'https://cloudresourcemanager.googleapis.com/v1/projects/fanki-424516'),
  );

  final content = [Content.text('Write a story about a magic backpack.')];
  final response = await gemini.generateContent(content);
  print(response);

  runApp(
    FAnkiApp(
      authenticationRepository: authenticationRepository,
      cardDeckManager: cardDeckManager,
    ),
  );
}

class VertexHttpClient extends BaseClient {
  VertexHttpClient(this._projectUrl);

  final String _projectUrl;
  final _client = Client();

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    if (request is! Request ||
        request.url.host != 'generativelanguage.googleapis.com') {
      return _client.send(request);
    }

    final vertexRequest = Request(
        request.method,
        Uri.parse(request.url.toString().replaceFirst(
            'https://generativelanguage.googleapis.com/v1/models',
            _projectUrl)))
      ..bodyBytes = request.bodyBytes;

    for (final header in request.headers.entries) {
      if (header.key != 'x-goog-api-key') {
        vertexRequest.headers[header.key] = header.value;
      }
    }

    vertexRequest.headers['Authorization'] =
        'Bearer ${request.headers['x-goog-api-key']}';

    return _client.send(vertexRequest);
  }
}
