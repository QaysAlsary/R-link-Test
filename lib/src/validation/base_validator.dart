abstract class BaseValidator {
  late final String msgKey;

  bool valid(String? input);

  String? validator(String? input) {
    if (!valid(input)) {
      return msgKey;
    }
    return null;
  }
}
