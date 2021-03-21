import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/common/constants/constants.dart';
import 'package:flash_chat_flutter/generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit.dart';

class SettingsScreen extends StatefulWidget {
  static String id = 'settings_screen';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final t = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.settings),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              t.language,
              textAlign: TextAlign.center,
              style: font_large_bold,
            ),
            SizedBox(height: 20),
            Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    S.load(Locale('en', 'US'));
                  });
                },
                child: Text(
                  'English',
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    S.load(Locale('ru', 'RU'));
                  });
                },
                child: Text(
                  'Русский',
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                t.yourName,
                textAlign: TextAlign.center,
                style: font_large_bold,
              ),
            ),
            Text(
              '//bloc ${t.practice}',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            BlocBuilder<NameCubit, String>(
              builder: (BuildContext context, name) {
                return Column(
                  children: [
                    TextField(
                      controller: TextEditingController(text: name),
                      onSubmitted: (value) => {
                        context.read<NameCubit>().changeName(value),
                        FocusScope.of(context).unfocus(),
                      },
                      decoration: InputDecoration(
                        hintText: t.nameInputPlaceholder,
                      ),
                      autocorrect: false,
                      textCapitalization: TextCapitalization.words,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      name.isNotEmpty ? '${t.welcome}, $name!' : '',
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
