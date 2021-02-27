import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/screens/welcome/welcome_screen.dart';
import 'package:flash_chat_flutter/screens/login/login_screen.dart';
import 'package:flash_chat_flutter/screens/registration/registration_screen.dart';
import 'package:flash_chat_flutter/screens/chat/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/movies/movies_screen.dart';
import 'screens/main/main_screen.dart';
import 'services/db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB.init();
  await Firebase.initializeApp();
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
        MoviesScreen.id: (context) => MoviesScreen(),
        MainScreen.id: (context) => MainScreen(),
      },
    );
  }
}
