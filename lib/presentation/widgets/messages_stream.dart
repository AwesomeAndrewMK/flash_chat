import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat_flutter/presentation/widgets/message_bubble.dart';

final _firestore = FirebaseFirestore.instance;

class MessagesStream extends StatelessWidget {
  MessagesStream({required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').orderBy('time').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Expanded(
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            ),
          );
        }
        final messages = snapshot.data!.docs.reversed;
        var messageWidgets = <MessageBubble>[];
        for (var message in messages) {
          final messageText = message.data()!['text'];
          final messageSender = message.data()!['sender'];

          final currentUser = email;

          var messageBubble = MessageBubble(
            text: messageText ?? '',
            sender: messageSender,
            isMe: currentUser == messageSender,
          );
          messageWidgets.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            physics: ClampingScrollPhysics(),
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            children: messageWidgets,
          ),
        );
      },
    );
  }
}
