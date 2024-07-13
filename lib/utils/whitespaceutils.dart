import 'package:flutter/material.dart';

class SpaceUtils {
  SpaceUtils._();

  ///SMALL SIZE SPACE
  static double ks7 = 7.0;
  static double ks8 = 8.0;
  static double ks10 = 10.0;
  static double ks14 = 14.0;
  static double ks16 = 16.0;
  static double ks18 = 18.0;

  ///MEDIUM SIZE SPACE
  static double ks20 = 20.0;
  static double ks24 = 24.0;
  static double ks30 = 30.0;
  static double ks40 = 40.0;
  static double ks50 = 50.0;

  ///LARGE SIZE SPACE
  static double ks60 = 60.0;
  static double ks65 = 65.0;
  static double ks75 = 75.0;
  static double ks100 = 100.0;
  static double ks120 = 120.0;
}

extension SmartHeight on double {
  SizedBox height() {
    return SizedBox(
      height: this,
    );
  }

  SizedBox width() {
    return SizedBox(
      width: this,
    );
  }
}
