import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String? avatar;

  const UserAvatar(this.avatar);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8),
      child: CircleAvatar(
        foregroundImage: avatar != null ? NetworkImage(avatar!) : null,
        backgroundImage: AssetImage('images/avatar_placeholder.png'),
      ),
    );
  }
}
