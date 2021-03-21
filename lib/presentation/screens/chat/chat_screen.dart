import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/common/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat_flutter/presentation/widgets/widgets.dart';
import 'package:flash_chat_flutter/generated/l10n.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String messageText = '';

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = S.of(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MessagesStream(
              email: loggedInUser.email ?? '',
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: messageTextController,
                      onChanged: (value) {
                        setState(() {
                          messageText = value;
                        });
                      },
                      decoration: kMessageTextFieldDecoration.copyWith(
                        hintText: t.messagePlaceholder,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      if (messageText.isNotEmpty) {
                        try {
                          await _firestore.collection('messages').add({
                            'text': messageText,
                            'sender': loggedInUser.email,
                            'time': DateTime.now().millisecondsSinceEpoch,
                          });
                          messageTextController.clear();
                        } catch (e) {
                          print(e);
                        }
                      }
                    },
                    child: Text(
                      t.send,
                      style: messageText.isNotEmpty
                          ? kSendButtonTextStyle
                          : kInactiveSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
