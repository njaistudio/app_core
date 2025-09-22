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
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class CoreS {
  CoreS();

  static CoreS? _current;

  static CoreS get current {
    assert(
      _current != null,
      'No instance of CoreS was loaded. Try to initialize the CoreS delegate before accessing CoreS.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<CoreS> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = CoreS();
      CoreS._current = instance;

      return instance;
    });
  }

  static CoreS of(BuildContext context) {
    final instance = CoreS.maybeOf(context);
    assert(
      instance != null,
      'No instance of CoreS present in the widget tree. Did you add CoreS.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static CoreS? maybeOf(BuildContext context) {
    return Localizations.of<CoreS>(context, CoreS);
  }

  /// `Needs Review`
  String get needsReview {
    return Intl.message(
      'Needs Review',
      name: 'needsReview',
      desc: '',
      args: [],
    );
  }

  /// `Mastered`
  String get mastered {
    return Intl.message('Mastered', name: 'mastered', desc: '', args: []);
  }

  /// `Already Known`
  String get alreadyKnown {
    return Intl.message(
      'Already Known',
      name: 'alreadyKnown',
      desc: '',
      args: [],
    );
  }

  /// `Next Review in {time}`
  String nextReviewIn(Object time) {
    return Intl.message(
      'Next Review in $time',
      name: 'nextReviewIn',
      desc: 'Append time value',
      args: [time],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<CoreS> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'bn'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'hi'),
      Locale.fromSubtags(languageCode: 'id'),
      Locale.fromSubtags(languageCode: 'it'),
      Locale.fromSubtags(languageCode: 'ko'),
      Locale.fromSubtags(languageCode: 'mn'),
      Locale.fromSubtags(languageCode: 'ms'),
      Locale.fromSubtags(languageCode: 'my'),
      Locale.fromSubtags(languageCode: 'ne'),
      Locale.fromSubtags(languageCode: 'pl'),
      Locale.fromSubtags(languageCode: 'pt'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'si'),
      Locale.fromSubtags(languageCode: 'th'),
      Locale.fromSubtags(languageCode: 'tr'),
      Locale.fromSubtags(languageCode: 'vi'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<CoreS> load(Locale locale) => CoreS.load(locale);
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
