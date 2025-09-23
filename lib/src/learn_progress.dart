import 'package:app_core/generated/l10n.dart';
import 'package:app_core/src/exts.dart';
import 'package:flutter/material.dart';
enum RememberTime {
  never,
  oneDay,
  twoDays,
  oneWeek,
}

class LearnProgress {
  LearnProgress(this.correctTimes, this.timeStamp);
  int correctTimes;
  int timeStamp;

  static const skipMark = 10000;

  bool enableForLearn(RememberTime rememberTime) {
    switch (rememberTime) {
      case RememberTime.never:
        return correctTimes == 0;
      case RememberTime.oneDay:
        return lastCorrectDuration > 1;
      case RememberTime.twoDays:
        return lastCorrectDuration > 2;
      case RememberTime.oneWeek:
        return lastCorrectDuration > 7;
    }
  }

  bool get needPractice {
    return learnStatus == LearnStatus.needReviewNow;
  }

  int get lastCorrectDuration {
    final now = DateTime.now();
    final duration = timeStamp == 0 ? 0 : now.difference(learnedTime).inDays;
    return duration;
  }

  Duration get nextReviewDuration {
    return learnedTime.subtract(Duration(days: -inReviewDay)).difference(DateTime.now());
  }

  String get nextReviewDurationString {
    final duration = nextReviewDuration;
    if (duration.isNegative) {
      return "0m";
    }

    int days = duration.inDays;
    int hours = duration.inHours.remainder(24);
    int minutes = duration.inMinutes.remainder(60);

    if (days > 0) {
      if(hours > 0) return "${days}d ${hours}h";

      return "${days}d";
    } else if (hours > 0) {
      return "${hours}h ${minutes}m";
    } else {
      return "${minutes}m";
    }
  }

  int get inReviewDay {
    if(correctTimes == 1) {
      return 1;
    }
    if(correctTimes == 2) {
      return 3;
    }
    if(correctTimes == 3) {
      return 7;
    }
    if(correctTimes >= 4) {
      return 30;
    }

    return 0;
  }

  bool get learned => learnStatus != LearnStatus.notLearned && learnStatus != LearnStatus.skipped;

  bool get needLearn => learnStatus == LearnStatus.notLearned;

  DateTime get learnedTime => DateTime.fromMillisecondsSinceEpoch(timeStamp);

  LearnStatus get learnStatus {
    if(correctTimes == 0) {
      return LearnStatus.notLearned;
    }
    if(correctTimes >= skipMark) {
      return LearnStatus.skipped;
    }
    if(correctTimes >= 5) {
      return LearnStatus.master;
    }
    if(DateTime.now().subtract(Duration(days: inReviewDay)).compareTo(learnedTime) > 0) {
      return LearnStatus.needReviewNow;
    }

    return LearnStatus.learnAndWaitingReview;
  }

  MaterialColor get learnStatusColor {
    return learnStatus.color;
  }

  String get learnStatusString {
    switch(learnStatus) {
      case LearnStatus.learnAndWaitingReview:
        return CoreS.current.nextReviewIn(nextReviewDurationString);
      case LearnStatus.notLearned:
      case LearnStatus.needReviewNow:
      case LearnStatus.master:
      case LearnStatus.skipped:
        return learnStatus.name;
    }
  }
}

enum LearnStatus {
  notLearned,
  learnAndWaitingReview,
  needReviewNow,
  master,
  skipped,
}

extension LearnStatusExtension on LearnStatus {
  String get name {
    switch(this) {
      case LearnStatus.notLearned:
      case LearnStatus.learnAndWaitingReview:
        return "";
      case LearnStatus.needReviewNow:
        return CoreS.current.needsReview;
      case LearnStatus.master:
        return CoreS.current.mastered;
      case LearnStatus.skipped:
        return CoreS.current.alreadyKnown;
    }
  }

  MaterialColor get color {
    switch(this) {
      case LearnStatus.notLearned:
        return Colors.grey;
      case LearnStatus.learnAndWaitingReview:
        return Colors.cyan;
      case LearnStatus.needReviewNow:
        return Colors.deepOrange;
      case LearnStatus.master:
        return Colors.indigo;
      case LearnStatus.skipped:
        return Colors.black.materialColor;
    }
  }
}
