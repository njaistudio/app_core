// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ko locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ko';

  static String m0(time) => "${time} 후 복습";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "alreadyKnown": MessageLookupByLibrary.simpleMessage("이미 알고 있음"),
    "continueLearning": MessageLookupByLibrary.simpleMessage("학습 계속하기"),
    "hardWord": MessageLookupByLibrary.simpleMessage("어려운 단어"),
    "markAsKnown": MessageLookupByLibrary.simpleMessage("알고 있는 것으로 표시"),
    "mastered": MessageLookupByLibrary.simpleMessage("완전히 숙달됨"),
    "needsReview": MessageLookupByLibrary.simpleMessage("복습 필요"),
    "nextReviewIn": m0,
  };
}
