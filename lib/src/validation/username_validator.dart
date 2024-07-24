import 'base_validator.dart';

class UserNameValidator extends BaseValidator {
  UserNameValidator();
  @override
  String get msgKey => "Input invalid form";

  @override
  bool valid(String? input) {
    if (input == null || input.isEmpty) {
      return false;
    }
    return validNumber(input)||validEmail(input);
  }

  bool validNumber(String input) => RegExp(r'(^09\d{8}$)').hasMatch(input);
  bool validEmail(String input) => RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(input);

}
