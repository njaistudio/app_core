// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a si locale. All the
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
  String get localeName => 'si';

  static String m0(time) => "${time} කට පසු නැවත සමාලෝචනය";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "alreadyKnown": MessageLookupByLibrary.simpleMessage("දැනටමත් දන්නවා"),
    "mastered": MessageLookupByLibrary.simpleMessage("මනස්කරුට ගත්තා"),
    "needsReview": MessageLookupByLibrary.simpleMessage(
      "නැවත සමාලෝචනය අවශ්‍යයි",
    ),
    "nextReviewIn": m0,
  };
}
