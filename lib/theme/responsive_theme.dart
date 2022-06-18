import 'package:flutter/material.dart';

class Responsive {
  static bool isMobile(BuildContext context) {
    final data = MediaQuery.of(context);
    return data.size.shortestSide < 600;
  }

  static bool isSmallTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 900 &&
      MediaQuery.of(context).size.width >= 600;
  static bool isLargeTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1250 &&
      MediaQuery.of(context).size.width >= 900;
  static bool isLaptop(BuildContext context) =>
      MediaQuery.of(context).size.width < 1450 &&
      MediaQuery.of(context).size.width >= 1250;
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1450;

  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }
}
