import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/presentation/screens/welcome/welcome_screen.dart';
import 'package:flash_chat_flutter/presentation/screens/login/login_screen.dart';
import 'package:flash_chat_flutter/presentation/screens/registration/registration_screen.dart';
import 'package:flash_chat_flutter/presentation/screens/chat/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat_flutter/presentation/screens/movies/movies_screen.dart';
import 'package:flash_chat_flutter/presentation/screens/main/main_screen.dart';
import 'package:flash_chat_flutter/data/services/db.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flash_chat_flutter/generated/l10n.dart';

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
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      builder: EasyLoading.init(),
    );
  }
}
