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

  /// `Hard word`
  String get hardWord {
    return Intl.message('Hard word', name: 'hardWord', desc: '', args: []);
  }

  /// `Continue learning`
  String get continueLearning {
    return Intl.message(
      'Continue learning',
      name: 'continueLearning',
      desc: '',
      args: [],
    );
  }

  /// `Mark as known`
  String get markAsKnown {
    return Intl.message(
      'Mark as known',
      name: 'markAsKnown',
      desc: '',
      args: [],
    );
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

  /// `Lifetime`
  String get lifetime {
    return Intl.message('Lifetime', name: 'lifetime', desc: '', args: []);
  }

  /// `Mon`
  String get t2 {
    return Intl.message('Mon', name: 't2', desc: '', args: []);
  }

  /// `Tue`
  String get t3 {
    return Intl.message('Tue', name: 't3', desc: '', args: []);
  }

  /// `Wed`
  String get t4 {
    return Intl.message('Wed', name: 't4', desc: '', args: []);
  }

  /// `Thu`
  String get t5 {
    return Intl.message('Thu', name: 't5', desc: '', args: []);
  }

  /// `Fri`
  String get t6 {
    return Intl.message('Fri', name: 't6', desc: '', args: []);
  }

  /// `Sat`
  String get t7 {
    return Intl.message('Sat', name: 't7', desc: '', args: []);
  }

  /// `Sun`
  String get cn {
    return Intl.message('Sun', name: 'cn', desc: '', args: []);
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Delete Account`
  String get deleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Continue`
  String get ok {
    return Intl.message('Continue', name: 'ok', desc: '', args: []);
  }

  /// `Do you want to delete all data?`
  String get deleteAccountQuestion {
    return Intl.message(
      'Do you want to delete all data?',
      name: 'deleteAccountQuestion',
      desc: '',
      args: [],
    );
  }

  /// `You need login again to do that!`
  String get deleteAccountDescription {
    return Intl.message(
      'You need login again to do that!',
      name: 'deleteAccountDescription',
      desc: '',
      args: [],
    );
  }

  /// `or`
  String get or {
    return Intl.message('or', name: 'or', desc: '', args: []);
  }

  /// `Please select your language!`
  String get selectLanguageTitle {
    return Intl.message(
      'Please select your language!',
      name: 'selectLanguageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please wait a second!`
  String get pleaseWaitASecond {
    return Intl.message(
      'Please wait a second!',
      name: 'pleaseWaitASecond',
      desc: '',
      args: [],
    );
  }

  /// `Initializing data`
  String get initializingData {
    return Intl.message(
      'Initializing data',
      name: 'initializingData',
      desc: '',
      args: [],
    );
  }

  /// `Update data`
  String get updateData {
    return Intl.message('Update data', name: 'updateData', desc: '', args: []);
  }

  /// `Updating data`
  String get updatingData {
    return Intl.message(
      'Updating data',
      name: 'updatingData',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message('Done', name: 'done', desc: '', args: []);
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `Tiếng Việt`
  String get vietnamese {
    return Intl.message('Tiếng Việt', name: 'vietnamese', desc: '', args: []);
  }

  /// `नेपाली`
  String get nepali {
    return Intl.message('नेपाली', name: 'nepali', desc: '', args: []);
  }

  /// `မြန်မာစာ`
  String get burmese {
    return Intl.message('မြန်မာစာ', name: 'burmese', desc: '', args: []);
  }

  /// `Bahasa Indonesia`
  String get indonesian {
    return Intl.message(
      'Bahasa Indonesia',
      name: 'indonesian',
      desc: '',
      args: [],
    );
  }

  /// `ไทย`
  String get thai {
    return Intl.message('ไทย', name: 'thai', desc: '', args: []);
  }

  /// `한국어`
  String get korean {
    return Intl.message('한국어', name: 'korean', desc: '', args: []);
  }

  /// `Français`
  String get french {
    return Intl.message('Français', name: 'french', desc: '', args: []);
  }

  /// `Italiano`
  String get italian {
    return Intl.message('Italiano', name: 'italian', desc: '', args: []);
  }

  /// `Deutsch`
  String get german {
    return Intl.message('Deutsch', name: 'german', desc: '', args: []);
  }

  /// `Русский`
  String get russian {
    return Intl.message('Русский', name: 'russian', desc: '', args: []);
  }

  /// `中文`
  String get chinese {
    return Intl.message('中文', name: 'chinese', desc: '', args: []);
  }

  /// `Bahasa Melayu`
  String get malay {
    return Intl.message('Bahasa Melayu', name: 'malay', desc: '', args: []);
  }

  /// `Português`
  String get portuguese {
    return Intl.message('Português', name: 'portuguese', desc: '', args: []);
  }

  /// `Монгол`
  String get mongolian {
    return Intl.message('Монгол', name: 'mongolian', desc: '', args: []);
  }

  /// `Español`
  String get spanish {
    return Intl.message('Español', name: 'spanish', desc: '', args: []);
  }

  /// `සිංහල`
  String get sinhala {
    return Intl.message('සිංහල', name: 'sinhala', desc: '', args: []);
  }

  /// `Türkçe`
  String get turkish {
    return Intl.message('Türkçe', name: 'turkish', desc: '', args: []);
  }

  /// `Polski`
  String get polish {
    return Intl.message('Polski', name: 'polish', desc: '', args: []);
  }

  /// `العربية`
  String get arabic {
    return Intl.message('العربية', name: 'arabic', desc: '', args: []);
  }

  /// `हिन्दी`
  String get hindi {
    return Intl.message('हिन्दी', name: 'hindi', desc: '', args: []);
  }

  /// `বাংলা`
  String get bengali {
    return Intl.message('বাংলা', name: 'bengali', desc: '', args: []);
  }

  /// `Hello!`
  String get hello {
    return Intl.message('Hello!', name: 'hello', desc: '', args: []);
  }

  /// `Login or link your account to buy premium package!`
  String get linkAccountToGetMore {
    return Intl.message(
      'Login or link your account to buy premium package!',
      name: 'linkAccountToGetMore',
      desc: '',
      args: [],
    );
  }

  /// `Upgrade to Premium to skip all ads`
  String get removeAds {
    return Intl.message(
      'Upgrade to Premium to skip all ads',
      name: 'removeAds',
      desc: '',
      args: [],
    );
  }

  /// `Or`
  String get adsOr {
    return Intl.message('Or', name: 'adsOr', desc: '', args: []);
  }

  /// `Link accounts`
  String get linkAccount {
    return Intl.message(
      'Link accounts',
      name: 'linkAccount',
      desc: '',
      args: [],
    );
  }

  /// `Year`
  String get perYear {
    return Intl.message('Year', name: 'perYear', desc: '', args: []);
  }

  /// `The app requires microphone permission to function.`
  String get microphone_permission_required {
    return Intl.message(
      'The app requires microphone permission to function.',
      name: 'microphone_permission_required',
      desc: '',
      args: [],
    );
  }

  /// `Microphone permission granted.`
  String get microphone_permission_granted {
    return Intl.message(
      'Microphone permission granted.',
      name: 'microphone_permission_granted',
      desc: '',
      args: [],
    );
  }

  /// `Please tap here to open settings and grant microphone permission.`
  String get microphone_open_settings {
    return Intl.message(
      'Please tap here to open settings and grant microphone permission.',
      name: 'microphone_open_settings',
      desc: '',
      args: [],
    );
  }

  /// `The app uses Speech Services by Google to convert text to speech.`
  String get tts_service_required {
    return Intl.message(
      'The app uses Speech Services by Google to convert text to speech.',
      name: 'tts_service_required',
      desc: '',
      args: [],
    );
  }

  /// `Speech Services by Google permission granted.`
  String get tts_service_granted {
    return Intl.message(
      'Speech Services by Google permission granted.',
      name: 'tts_service_granted',
      desc: '',
      args: [],
    );
  }

  /// `Please tap here to open Speech Services by Google settings.`
  String get tts_open_settings {
    return Intl.message(
      'Please tap here to open Speech Services by Google settings.',
      name: 'tts_open_settings',
      desc: '',
      args: [],
    );
  }

  /// `Done, please check again.`
  String get check_done {
    return Intl.message(
      'Done, please check again.',
      name: 'check_done',
      desc: '',
      args: [],
    );
  }

  /// `Microphone error?`
  String get microphone_error {
    return Intl.message(
      'Microphone error?',
      name: 'microphone_error',
      desc: '',
      args: [],
    );
  }

  /// `Current streak`
  String get currentStreak {
    return Intl.message(
      'Current streak',
      name: 'currentStreak',
      desc: '',
      args: [],
    );
  }

  /// `Longest streak`
  String get longestStreak {
    return Intl.message(
      'Longest streak',
      name: 'longestStreak',
      desc: '',
      args: [],
    );
  }

  /// `Daily goals`
  String get dailyGoals {
    return Intl.message('Daily goals', name: 'dailyGoals', desc: '', args: []);
  }

  /// `words/day`
  String get wordsPerDay {
    return Intl.message('words/day', name: 'wordsPerDay', desc: '', args: []);
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
