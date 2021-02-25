import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flash_chat_flutter/constants.dart';
import 'dart:io';

class Loader extends StatelessWidget {
  bool _isPlatformIOS() {
    return Platform.isIOS;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _isPlatformIOS()
          ? CupertinoActivityIndicator()
          : CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(mainAppColor),
            ),
    );
  }
}
