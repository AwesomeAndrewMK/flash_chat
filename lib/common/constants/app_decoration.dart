import 'package:flutter/material.dart';
import 'colors.dart';

abstract class AppDecoration {
  static final MESSAGE_TEXT_FIELD_DECORATION = InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    hintText: 'Type your message here...',
    border: InputBorder.none,
  );

  static final MESSAGE_CONTAINER_DECORATION = BoxDecoration(
    border: Border(
      top: BorderSide(color: ProjectCodeColors.MAIN_COLOR, width: 2.0),
    ),
  );

  static final TEXT_FIELD_DECORATION = InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  );
}
