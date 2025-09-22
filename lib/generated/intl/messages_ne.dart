// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ne locale. All the
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
  String get localeName => 'ne';

  static String m0(time) => "${time} पछि पुनरावलोकन";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "alreadyKnown": MessageLookupByLibrary.simpleMessage("पहिले देखि जान्ने"),
    "continueLearning": MessageLookupByLibrary.simpleMessage(
      "अध्ययन जारी राख्नुहोस्",
    ),
    "hardWord": MessageLookupByLibrary.simpleMessage("गाह्रो शब्द"),
    "markAsKnown": MessageLookupByLibrary.simpleMessage(
      "चिनिएका रूपमा चिन्ह लगाउनुहोस्",
    ),
    "mastered": MessageLookupByLibrary.simpleMessage("निपुण"),
    "needsReview": MessageLookupByLibrary.simpleMessage("पुनरावलोकन आवश्यक"),
    "nextReviewIn": m0,
  };
}
