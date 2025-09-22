// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a bn locale. All the
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
  String get localeName => 'bn';

  static String m0(time) => "${time} পর পুনরায় পড়া";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "alreadyKnown": MessageLookupByLibrary.simpleMessage("ইতিমধ্যেই জানা"),
    "continueLearning": MessageLookupByLibrary.simpleMessage(
      "শেখা চালিয়ে যাও",
    ),
    "hardWord": MessageLookupByLibrary.simpleMessage("কঠিন শব্দ"),
    "markAsKnown": MessageLookupByLibrary.simpleMessage(
      "জানা হিসেবে চিহ্নিত কর",
    ),
    "mastered": MessageLookupByLibrary.simpleMessage("আয়ত্ত হয়েছে"),
    "needsReview": MessageLookupByLibrary.simpleMessage(
      "পুনরায় পড়া প্রয়োজন",
    ),
    "nextReviewIn": m0,
  };
}
