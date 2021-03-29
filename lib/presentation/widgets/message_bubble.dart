import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/common/constants/constants.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble({
    required this.sender,
    required this.text,
    required this.isMe,
  });

  final String sender;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: Fonts.FONT_SMALL,
          ),
          Material(
            borderRadius: BorderRadius.only(
              topLeft: isMe ? Radius.circular(30) : Radius.zero,
              topRight: isMe ? Radius.zero : Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            elevation: 5,
            color: isMe ? ProjectCodeColors.MAIN_COLOR : ProjectCodeColors.WHITE_COLOR,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 15,
                  color: isMe ? ProjectCodeColors.WHITE_COLOR : ProjectCodeColors.BLACK_COLOR,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
