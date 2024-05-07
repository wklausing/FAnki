import 'package:uuid/uuid.dart';

class SingleCard {
  String id;
  String deckName;
  String questionText;
  String answerText;

  SingleCard({
    String id = 'none',
    required this.deckName,
    required this.questionText,
    required this.answerText,
  }) : id = id == 'none' ? Uuid().v4() : id;

  factory SingleCard.fromMap(Map<String, dynamic> map) {
    final String? id = map['id'];
    final String? deckName = map['deckname'];
    final String? questionText = map['question'];
    final String? answerText = map['answer'];

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
    );
  }

  Map<String, String> cardToMap() {
    return {
      'id': id,
      'deckname': deckName,
      'question': questionText,
      'answer': answerText,
    };
  }
}
