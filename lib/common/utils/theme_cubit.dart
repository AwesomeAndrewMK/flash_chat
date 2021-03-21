import 'package:bloc/bloc.dart';
import 'package:flash_chat_flutter/data/services/themeValue.dart';

class ThemeCubit extends Cubit<bool> {
  ThemeCubit(bool value) : super(value);

  void switchTheme() {
    ThemeValue.toggleThemeValue();
    emit(!state);
  }
}
