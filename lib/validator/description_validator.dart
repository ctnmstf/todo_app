import 'package:formz/formz.dart';

enum DescriptionValidationError { empty }

class DescriptionV extends FormzInput<String, DescriptionValidationError> {
  const DescriptionV.pure() : super.pure('');
  const DescriptionV.dirty([String value = '']) : super.dirty(value);

  @override
  DescriptionValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : DescriptionValidationError.empty;
  }
}