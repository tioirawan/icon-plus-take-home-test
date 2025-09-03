import 'package:flutter/widgets.dart';

class AppDimensions {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;

  static const EdgeInsets pagePadding = EdgeInsets.symmetric(horizontal: md);
  static const EdgeInsets cardPadding = EdgeInsets.all(md);

  static const Radius radiusSm = Radius.circular(sm);
  static const Radius radiusMd = Radius.circular(md);

  static BorderRadius borderRadiusSm = BorderRadius.circular(sm);
  static BorderRadius borderRadiusMd = BorderRadius.circular(md);
}
