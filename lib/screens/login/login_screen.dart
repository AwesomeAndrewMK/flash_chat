import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/components/main_button.dart';
import 'package:flash_chat_flutter/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../main/main_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  String email;
  String password;

  bool _showSpinner = false;

  @override
  Widget build(BuildContext context) {
    Future<UserCredential> signInWithFacebook() async {
      final AccessToken accessToken = await FacebookAuth.instance.login();
      final FacebookAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(accessToken.token);
      await _auth.signInWithCredential(facebookAuthCredential);
      Navigator.pushNamedAndRemoveUntil(
        context,
        MainScreen.id,
        (route) => false,
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
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
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your email',
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
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password',
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              MainButton(
                title: 'Log in',
                boxDecoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(24),
                ),
                onPressed: () async {
                  setState(() {
                    _showSpinner = true;
                  });
                  try {
                    final registeredUser =
                        await _auth.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    if (registeredUser != null) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        MainScreen.id,
                        (route) => false,
                      );
                    }
                    setState(() {
                      _showSpinner = false;
                    });
                  } catch (e) {
                    final snackBar = SnackBar(
                      content: Text(e.toString()),
                      backgroundColor: Colors.red,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    setState(() {
                      _showSpinner = false;
                    });
                  }
                },
              ),
              SizedBox(
                height: 16,
              ),
              MainButton(
                title: 'CONTINUE WITH FACEBOOK',
                onPressed: signInWithFacebook,
                boxDecoration: BoxDecoration(
                  color: Colors.blueAccent,
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
