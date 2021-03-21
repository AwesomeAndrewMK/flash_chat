import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flash_chat_flutter/generated/l10n.dart';

class AppExitAlertDialog extends StatelessWidget {
  final VoidCallback onExitPress;

  AppExitAlertDialog({required this.onExitPress});

  bool _isPlatformIOS() {
    return Platform.isIOS;
  }

  @override
  Widget build(BuildContext context) {
    final t = S.of(context);

    return _isPlatformIOS()
        ? CupertinoAlertDialog(
            title: Text(t.exitMessage),
            actions: [
              CupertinoDialogAction(
                onPressed: onExitPress,
                child: Text(t.yes),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(t.no),
              )
            ],
          )
        : AlertDialog(
            title: Text(t.exitMessage),
            actions: [
              TextButton(
                onPressed: onExitPress,
                child: Text(t.yes),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(t.no),
              ),
            ],
          );
  }
}
