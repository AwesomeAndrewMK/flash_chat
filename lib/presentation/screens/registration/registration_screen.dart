import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/presentation/widgets/widgets.dart';
import 'package:flash_chat_flutter/presentation/screens/screens.dart';
import 'package:flash_chat_flutter/common/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flash_chat_flutter/generated/l10n.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  late String errorMessage = '';

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final t = S.of(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: AbsorbPointer(
          absorbing: isLoading,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
                decoration: AppDecoration.TEXT_FIELD_DECORATION.copyWith(
                  hintText: t.emailPlaceholder,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                autocorrect: false,
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                decoration: AppDecoration.TEXT_FIELD_DECORATION.copyWith(
                  hintText: t.passwordPlaceholder,
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              MainButton(
                title: t.register,
                color: ProjectCodeColors.BLUE_ACCENT_COLOR,
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  setState(() {
                    isLoading = true;
                  });
                  try {
                    await EasyLoading.show(status: t.loading);
                    await _auth.createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    await EasyLoading.dismiss();
                    await Navigator.pushNamedAndRemoveUntil(
                      context,
                      ChatScreen.id,
                      (route) => false,
                    );
                    setState(() {
                      isLoading = false;
                    });
                  } catch (e) {
                    await EasyLoading.dismiss();
                    setState(() {
                      errorMessage = e.toString();
                      isLoading = false;
                    });
                  }
                },
              ),
              errorMessage.isNotEmpty
                  ? Text(
                      errorMessage,
                      style: TextStyle(
                        color: ProjectCodeColors.RED_COLOR,
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
