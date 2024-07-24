import 'base_validator.dart';

class PhoneValidator extends BaseValidator {
  PhoneValidator();
  @override
  String get msgKey => "Phone number invalid form";

  @override
  bool valid(String? input) {
    if (input == null || input.isEmpty) {
      return false;
    }
    return validSy(input);
  }

  bool validSy(String input) => RegExp(r'(^09\d{8}$)').hasMatch(input);

}
