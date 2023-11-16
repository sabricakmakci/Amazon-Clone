import 'package:amazon_clone/utils/regexp/regexp_helper.dart';

class StringValidators {
  static bool isValidName(String name) {
    if (!RegexpHelper.nameRegExp.hasMatch(name)) {
      return false;
    }
    if (name.length < 2 || name.length > 50 || name.endsWith(" ")) {
      return false;
    }
    return true;
  }
}
