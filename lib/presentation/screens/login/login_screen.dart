import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/presentation/widgets/widgets.dart';
import 'package:flash_chat_flutter/common/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flash_chat_flutter/presentation/screens/screens.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flash_chat_flutter/generated/l10n.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late String email;
  late String password;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final t = S.of(context);

    Future<void> signInWithFacebook() async {
      setState(() {
        isLoading = true;
      });
      FocusScope.of(context).unfocus();
      try {
        await EasyLoading.show(status: t.loading);
        final accessToken = await FacebookAuth.instance.login();
        final facebookAuthCredential =
            FacebookAuthProvider.credential(accessToken?.token ?? '');
        await _auth.signInWithCredential(facebookAuthCredential);
        await EasyLoading.dismiss();
        await Navigator.pushNamedAndRemoveUntil(
          context,
          MainScreen.id,
          (route) => false,
        );
        setState(() {
          isLoading = false;
        });
      } catch (e) {
        await EasyLoading.dismiss();
        setState(() {
          isLoading = false;
        });
      }
    }

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
                title: t.logIn,
                boxDecoration: BoxDecoration(
                  color: ProjectCodeColors.LIGHT_BLUE_ACCENT_COLOR,
                  borderRadius: BorderRadius.circular(24),
                ),
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  setState(() {
                    isLoading = true;
                  });
                  try {
                    await EasyLoading.show(status: t.loading);
                    await _auth.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    await EasyLoading.dismiss();
                    await Navigator.pushNamedAndRemoveUntil(
                      context,
                      MainScreen.id,
                      (route) => false,
                    );
                    setState(() {
                      isLoading = false;
                    });
                  } catch (e) {
                    final snackBar = SnackBar(
                      content: Text(e.toString()),
                      backgroundColor: ProjectCodeColors.RED_COLOR,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    await EasyLoading.dismiss();
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
              ),
              SizedBox(
                height: 16,
              ),
              MainButton(
                title: t.facebookLogin.toUpperCase(),
                onPressed: signInWithFacebook,
                boxDecoration: BoxDecoration(
                  color: ProjectCodeColors.BLUE_ACCENT_COLOR,
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
