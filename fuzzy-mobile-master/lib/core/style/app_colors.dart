import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
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
