import 'base_validator.dart';

class RequiredValidator extends BaseValidator {
  @override
  String get msgKey => "Required field";

  @override
  bool valid(String? input) => input != null && input.isNotEmpty;
}
