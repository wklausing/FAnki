import 'package:uuid/uuid.dart';

class SingleCard {
  String id;
  String deckName;
  String questionText;
  String answerText;
  double _difficulty;

  SingleCard({
    String id = 'none',
    required this.deckName,
    required this.questionText,
    required this.answerText,
    double difficulty = 1.0,
  })  : _difficulty = difficulty,
        id = id == 'none' ? const Uuid().v4() : id;

  factory SingleCard.fromMap(Map<String, dynamic> map) {
    final String? id = map['id'];
    final String? deckName = map['deckname'];
    final String? questionText = map['question'];
    final String? answerText = map['answer'];
    final double difficulty = (map['difficulty'] ?? 1.0) as double;

    if (id == null ||
        deckName == null ||
        questionText == null ||
        answerText == null) {
      throw ArgumentError('Missing data for SingleCard.fromMap');
    }

    return SingleCard(
      id: id,
      deckName: deckName,
      questionText: questionText,
      answerText: answerText,
      difficulty: difficulty,
    );
  }

  Map<String, dynamic> cardToMap() {
    return {
      'id': id,
      'deckname': deckName,
      'question': questionText,
      'answer': answerText,
      'difficulty': difficulty,
    };
  }

  double get difficulty => _difficulty;

  set difficulty(double value) {
    if (value > 1.0) {
      value = 1.0;
    } else if (value < 0.01) {
      value = 0.01;
    }
    _difficulty = value;
  }
}
