import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    Key key,
    @required String avatar,
  }) : _avatar = avatar, super(key: key);

  final String _avatar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8),
      child: CircleAvatar(
        backgroundImage: _avatar != null
            ? NetworkImage(_avatar)
            : AssetImage('images/avatar_placeholder.png'),
      ),
    );
  }
}