
import 'dart:ui';

import 'package:flutter/cupertino.dart';

class AppColors {
  static const Color mainColor = Color(0xFF1565C0);
  static const Color secondaryColor = Color(0xFF1F2937);
  static const Color textColor = Color(0xFF1A1A1A);
  static const Color buttonColor = Color(0xFF1565C0);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color blackColor = Color(0xFF000000);

  static LinearGradient buttonGradient = LinearGradient(
    colors: [
      Color(0xFF0F2D6B),
      Color(0xFF1565C0),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );


}