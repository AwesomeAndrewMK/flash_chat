import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class AppExitAlertDialog extends StatelessWidget {
  final VoidCallback onExitPress;

  AppExitAlertDialog({this.onExitPress});

  bool _isPlatformIOS() {
    return Platform.isIOS;
  }

  @override
  Widget build(BuildContext context) {
    return _isPlatformIOS()
        ? CupertinoAlertDialog(
            title: Text('Are you sure you want to exit?'),
            actions: [
              CupertinoDialogAction(
                child: Text('Yes'),
                onPressed: onExitPress,
              ),
              CupertinoDialogAction(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          )
        : AlertDialog(
            title: Text('Are you sure you want to exit?'),
            actions: [
              TextButton(
                child: Text('Yes'),
                onPressed: onExitPress,
              ),
              TextButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
  }
}
