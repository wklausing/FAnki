import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageSettingsPersistence {
  final Future<SharedPreferences> instanceFuture =
      SharedPreferences.getInstance();

  Future<String> getCurrentDeck() async {
    final prefs = await instanceFuture;
    return prefs.getString('currentDeck') ?? 'default';
  }

  Future<void> setCurrentDeck(String deckName) async {
    final prefs = await instanceFuture;
    prefs.setString('currentDeck', deckName);
  }
}
