import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension GetTheme on BuildContext {
  TextTheme get baseTextTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  TextTheme get textTheme {

    return baseTextTheme.copyWith(
      displayLarge: baseTextTheme.displayLarge?.adaptive,
      displayMedium: baseTextTheme.displayMedium?.adaptive,
      displaySmall: baseTextTheme.displaySmall?.adaptive,

      headlineLarge: baseTextTheme.headlineLarge?.adaptive,
      headlineMedium: baseTextTheme.headlineMedium?.adaptive,
      headlineSmall: baseTextTheme.headlineSmall?.adaptive,

      titleLarge: baseTextTheme.titleLarge?.adaptive,
      titleMedium: baseTextTheme.titleMedium?.adaptive,
      titleSmall: baseTextTheme.titleSmall?.adaptive,

      bodyLarge: baseTextTheme.bodyLarge?.adaptive,
      bodyMedium: baseTextTheme.bodyMedium?.adaptive,
      bodySmall: baseTextTheme.bodySmall?.adaptive,

      labelLarge: baseTextTheme.labelLarge?.adaptive,
      labelMedium: baseTextTheme.labelMedium?.adaptive,
      labelSmall: baseTextTheme.labelSmall?.adaptive,
    );
  }
}

extension AdaptiveTextStyle on TextStyle? {
  TextStyle? get adaptive {
    if (this == null || this!.fontSize == null) return this;

    final double shortestSide = ScreenUtil().screenWidth < ScreenUtil().screenHeight
        ? ScreenUtil().screenWidth
        : ScreenUtil().screenHeight;

    final bool isTablet = shortestSide >= 600;
    return isTablet ? this!.copyWith(fontSize: this!.fontSize!.sp) : this;
  }
}

extension ColorExt on Color {
  MaterialColor get materialColor {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = red, g = green, b = blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(value, swatch);
  }
}