import 'package:formz/formz.dart';

enum DeckNameValidationError { empty }

class DeckName extends FormzInput<String, DeckNameValidationError> {
  const DeckName.pure() : super.pure('');
  const DeckName.dirty([super.value = '']) : super.dirty();

  @override
  DeckNameValidationError? validator(String value) {
    if (value.isEmpty) return DeckNameValidationError.empty;
    return null;
  }
}
