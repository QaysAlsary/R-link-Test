import 'package:flutter/material.dart';

extension ConvertToMaterial on Color {
  toMaterialColor() {
    Map<int, Color> values = const {
      50: Color.fromRGBO(20, 179, 151, .1),
      100: Color.fromRGBO(20, 179, 151, .2),
      200: Color.fromRGBO(20, 179, 151, .3),
      300: Color.fromRGBO(20, 179, 151, .4),
      400: Color.fromRGBO(20, 179, 151, .5),
      500: Color.fromRGBO(20, 179, 151, .6),
      600: Color.fromRGBO(20, 179, 151, .7),
      700: Color.fromRGBO(20, 179, 151, .8),
      800: Color.fromRGBO(20, 179, 151, .9),
      900: Color.fromRGBO(20, 179, 151, 1.0),
    };
    return MaterialColor(value, values);
  }
}
//extension to provide the path used like this static
// String logo = 'ic_logo.svg'.iconAssetPath;
extension AssetsPath on String {
  String get imageAssetPath => 'assets/images/$this';

  String get iconAssetPath => 'assets/icons/$this';
}
