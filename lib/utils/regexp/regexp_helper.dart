import 'package:flutter/services.dart';

class RegexpHelper {
  static RegExp nameRegExp = RegExp(r'^[a-zA-AÇçĞğİıÖöŞşÜü ]+');
  static RegExp numberRegExp = RegExp(r'^[0-9]+$');

  static FilteringTextInputFormatter textRegex() {
    return FilteringTextInputFormatter.allow(nameRegExp);
  }
}
