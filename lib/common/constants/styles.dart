import 'package:flutter/material.dart';
import 'colors.dart';

abstract class Styles {
  static const SEND_BUTTON_TEXT_STYLE = TextStyle(
    color: ProjectCodeColors.MAIN_COLOR,
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
  );

  static const INACTIVE_SEND_BUTTON_TEXT_STYLE = TextStyle(
    color: ProjectCodeColors.GREY_COLOR,
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
  );
}
