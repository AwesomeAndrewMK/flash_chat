import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
  color: mainAppColor,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kInactiveSendButtonTextStyle = TextStyle(
  color: Colors.grey,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: mainAppColor, width: 2.0),
  ),
);

const kTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
);

const Color mainAppColor = Color(0xFF009488);
