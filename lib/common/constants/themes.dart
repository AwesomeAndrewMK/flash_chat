import 'package:flutter/material.dart';
import 'colors.dart';

abstract class Themes {
  static final DARK_THEME = ThemeData(
    primarySwatch: ProjectCodeColors.MATERIAL_GREY_COLOR,
    primaryColor: ProjectCodeColors.BLACK_COLOR,
    brightness: Brightness.dark,
    backgroundColor: ProjectCodeColors.DARK_THEME_BACKGROUND_COLOR,
    accentColor: ProjectCodeColors.WHITE_COLOR,
    accentIconTheme: IconThemeData(color: ProjectCodeColors.BLACK_COLOR),
    dividerColor: ProjectCodeColors.DARK_DIVIDER_COLOR,
  );

  static final LIGHT_THEME = ThemeData(
    primarySwatch: ProjectCodeColors.MATERIAL_GREY_COLOR,
    primaryColor: ProjectCodeColors.WHITE_COLOR,
    brightness: Brightness.light,
    backgroundColor: ProjectCodeColors.LIGHT_THEME_BACKGROUND_COLOR,
    accentColor: ProjectCodeColors.BLACK_COLOR,
    accentIconTheme: IconThemeData(color: ProjectCodeColors.WHITE_COLOR),
    dividerColor: ProjectCodeColors.LIGHT_DIVIDER_COLOR,
    appBarTheme: AppBarTheme(color: ProjectCodeColors.MAIN_COLOR),
  );
}
