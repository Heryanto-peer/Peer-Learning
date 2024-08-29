import 'package:flutter/material.dart';

class AppColors {
  static final red = _Red();
  static final blue = _Blue();
  static final black = _Black();
  static final white = _White();
  static final green = _Green();
  static final grey = _Grey();
  static final base = _Base();
  static final usedFor = _UsedFor();
}

class _Base {
  final Color primary = const Color(0xFF0073e6);
  final Color secondary = const Color(0xFF39e600);
  final Color tertiary = const Color(0xFFFFFFFF);

  final Color black = const Color(0xFF000000);
  final Color red = const Color(0xFFFF0000);
  final Color lightBlue = const Color(0xFF005bb5);
  final Color grey = const Color(0xFFA0A0A0);
  final Color neonGreen = const Color(0xFF2ca000);
  final Color orange = const Color(0xFFFF9900);
  final Color gold = const Color(0xFFFFD700);
}

/// group of color black
class _Black {
  Color get primary => const Color(0xFF000000);
  Color get text => const Color(0xBA130303);
}

/// group of color blue
class _Blue {
  Color get primary => const Color(0xFF2196F3);
  Color get secondary => const Color(0xFFBBDEFB);
  Color get table => const Color(0xFFBDDCF1);
}

/// group of color green
class _Green {
  Color get success => const Color(0xFF439946);
}

/// group of color grey
class _Grey {
  Color get primary => const Color(0xFF9E9E9E);
}

/// group of color red
class _Red {
  Color get error => const Color(0xFFB80808);
  Color get primary => const Color(0xFFF44336);
  Color get redSky => const Color(0xFFE57373);
}

class _UsedFor {
  final Color canvas = _Base().tertiary;
  final Color text = _Base().black;
  final Color error = _Base().red;
  final Color success = _Base().secondary;
  final Color warning = _Base().orange;
  final Color popupBox = _Base().lightBlue;
  final Color popupText = _Base().tertiary;
  final Color buttonBox = _Base().primary;
  final Color buttonText = _Base().tertiary;
  final Color buttonBox2 = _Base().secondary;
  final Color buttonDisable = _Base().grey;
  final Color icon = _Base().lightBlue;
  final Color border = _Base().lightBlue;
  final Color border2 = _Base().neonGreen;
  final Color borderDisable = _Base().grey;
}

/// group of color white
class _White {
  Color get primary => const Color(0xFFFFFFFF);
  Color get table => const Color(0xFFF8F7F7);
  Color get text => const Color(0xFFFFFFFF);
}
