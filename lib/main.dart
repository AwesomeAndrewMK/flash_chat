import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat_flutter/presentation/screens/screens.dart';
import 'package:flash_chat_flutter/data/services/db.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flash_chat_flutter/generated/l10n.dart';
import 'package:flash_chat_flutter/presentation/screens/settings/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flash_chat_flutter/common/constants/constants.dart';
import 'package:flash_chat_flutter/common/utils/theme_cubit.dart';
import 'package:flash_chat_flutter/data/services/theme_value.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB.init();
  await Firebase.initializeApp();
  await ThemeValue.getValue();
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NameCubit()),
        BlocProvider(create: (context) => ThemeCubit(ThemeValue.value)),
      ],
      child: BlocBuilder<ThemeCubit, bool>(
        builder: (BuildContext context, value) {
          return MaterialApp(
            theme: value ? Themes.DARK_THEME : Themes.LIGHT_THEME,
            initialRoute: WelcomeScreen.id,
            routes: {
              WelcomeScreen.id: (context) => WelcomeScreen(),
              LoginScreen.id: (context) => LoginScreen(),
              RegistrationScreen.id: (context) => RegistrationScreen(),
              ChatScreen.id: (context) => ChatScreen(),
              MoviesScreen.id: (context) => MoviesScreen(),
              MainScreen.id: (context) => MainScreen(),
              SettingsScreen.id: (context) => SettingsScreen(),
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
        },
      ),
    );
  }
}
