import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class AppExitAlertDialog extends StatelessWidget {
  final VoidCallback onExitPress;

  AppExitAlertDialog({required this.onExitPress});

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
                onPressed: onExitPress,
                child: Text('Yes'),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('No'),
              )
            ],
          )
        : AlertDialog(
            title: Text('Are you sure you want to exit?'),
            actions: [
              TextButton(
                onPressed: onExitPress,
                child: Text('Yes'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('No'),
              ),
            ],
          );
  }
}
