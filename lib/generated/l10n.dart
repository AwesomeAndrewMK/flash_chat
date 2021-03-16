// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null, 'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;
 
      return instance;
    });
  } 

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null, 'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Flash chat`
  String get appTitle {
    return Intl.message(
      'Flash chat',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `and movies!`
  String get appAdditionalTitle {
    return Intl.message(
      'and movies!',
      name: 'appAdditionalTitle',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get logIn {
    return Intl.message(
      'Log in',
      name: 'logIn',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get emailPlaceholder {
    return Intl.message(
      'Enter your email',
      name: 'emailPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get passwordPlaceholder {
    return Intl.message(
      'Enter your password',
      name: 'passwordPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Facebook`
  String get facebookLogin {
    return Intl.message(
      'Continue with Facebook',
      name: 'facebookLogin',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loading {
    return Intl.message(
      'Loading...',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Films`
  String get films {
    return Intl.message(
      'Films',
      name: 'films',
      desc: '',
      args: [],
    );
  }

  /// `Favourites`
  String get favourites {
    return Intl.message(
      'Favourites',
      name: 'favourites',
      desc: '',
      args: [],
    );
  }

  /// `Add to favourites`
  String get addToFavourites {
    return Intl.message(
      'Add to favourites',
      name: 'addToFavourites',
      desc: '',
      args: [],
    );
  }

  /// `In favourites`
  String get inFavourites {
    return Intl.message(
      'In favourites',
      name: 'inFavourites',
      desc: '',
      args: [],
    );
  }

  /// `No favourite movies here!`
  String get noFavourites {
    return Intl.message(
      'No favourite movies here!',
      name: 'noFavourites',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share {
    return Intl.message(
      'Share',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Average score`
  String get averageScore {
    return Intl.message(
      'Average score',
      name: 'averageScore',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Type your message here...`
  String get messagePlaceholder {
    return Intl.message(
      'Type your message here...',
      name: 'messagePlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to exit?`
  String get exitMessage {
    return Intl.message(
      'Are you sure you want to exit?',
      name: 'exitMessage',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Oops, data loading error! Please check your internet connection or try later.`
  String get fetchError {
    return Intl.message(
      'Oops, data loading error! Please check your internet connection or try later.',
      name: 'fetchError',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru', countryCode: 'RU'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}