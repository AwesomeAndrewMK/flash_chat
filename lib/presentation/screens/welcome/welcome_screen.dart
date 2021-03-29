import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat_flutter/presentation/widgets/widgets.dart';
import 'package:flash_chat_flutter/common/constants/constants.dart';
import 'package:flash_chat_flutter/generated/l10n.dart';
import 'package:flash_chat_flutter/presentation/screens/screens.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flash_chat_flutter/common/utils/theme_cubit.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    animation = ColorTween(
      begin: ProjectCodeColors.BLUE_GREY_COLOR,
    ).animate(controller);

    controller.forward();

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = S.of(context);

    return Scaffold(
      backgroundColor: animation.value,
      appBar: AppBar(
        title: Row(
          children: [
            BlocBuilder<ThemeCubit, bool>(
              builder: (context, value) {
                return GestureDetector(
                  onTap: context.read<ThemeCubit>().switchTheme,
                  child: value
                      ? Icon(
                          Icons.nightlight_round,
                          color: ProjectCodeColors.WHITE_COLOR,
                        )
                      : Icon(
                          Icons.wb_sunny,
                          color: ProjectCodeColors.YELLOW_COLOR,
                        ),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: [
                Hero(
                  tag: 'logo',
                  child: Container(
                    height: 60,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TypewriterAnimatedTextKit(
                        text: [t.appTitle],
                        speed: Duration(milliseconds: 200),
                        textStyle: Fonts.FONT_LOGO,
                      ),
                      TypewriterAnimatedTextKit(
                        text: [t.appAdditionalTitle],
                        speed: Duration(milliseconds: 200),
                        textStyle: Fonts.FONT_LOGO,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            MainButton(
              title: t.logIn,
              color: ProjectCodeColors.LIGHT_BLUE_ACCENT_COLOR,
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            SizedBox(
              height: 16,
            ),
            MainButton(
              title: t.register,
              color: ProjectCodeColors.BLUE_ACCENT_COLOR,
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
            SizedBox(height: 30),
            MainButton(
              title: t.settings,
              color: ProjectCodeColors.BLUE_GREY_COLOR,
              onPressed: () {
                Navigator.pushNamed(context, SettingsScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
