import 'package:flutter/material.dart';
import 'colors.dart';

abstract class Fonts {
  static const FONT_SMALL = TextStyle(
    fontSize: 12,
  );

  static const FONT_MEDIUM = TextStyle(
    fontSize: 16,
  );

  static const FONT_MEDIUM_BOLD = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static const FONT_LARGE = TextStyle(
    fontSize: 24,
  );

  static const FONT_LARGE_BOLD = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const FONT_LOGO = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.w900,
    color: ProjectCodeColors.BLACK_COLOR,
  );

  static const FONT_TITLE = TextStyle(
    fontSize: 20,
  );

  static const FONT_MOVIE_TITLE = TextStyle(
    fontWeight: FontWeight.bold,
    fontFamily: 'Anton',
    fontSize: 24,
  );

  static const FONT_MOVIE_DESCRIPTION = TextStyle(
    fontFamily: 'Rajdhani',
    fontSize: 18,
  );
}
