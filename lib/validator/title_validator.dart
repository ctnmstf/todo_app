import 'package:formz/formz.dart';

enum TitleValidationError { empty }

class TitleV extends FormzInput<String, TitleValidationError> {
  const TitleV.pure() : super.pure('');
  const TitleV.dirty([String value = '']) : super.dirty(value);

  @override
  TitleValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : TitleValidationError.empty;
  }
}
