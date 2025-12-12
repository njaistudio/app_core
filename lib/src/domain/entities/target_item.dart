import 'package:app_core/app_core.dart';

class TargetItem {
  int weekDay;
  int target;
  int score;
  bool isHighlight = false;

  List<String> dayNames = [
    CoreS.current.t2,
    CoreS.current.t3,
    CoreS.current.t4,
    CoreS.current.t5,
    CoreS.current.t6,
    CoreS.current.t7,
    CoreS.current.cn,
  ];

  TargetItem(this.weekDay, this.target, this.score);

  static TargetItem fromString(String string) {
    if(string.isEmpty) {
      return TargetItem(0, 0, 0);
    }
    var items = string.split("-").map((e) => int.parse(e)).toList();
    return TargetItem(items[0], items[1], items[2]);
  }

  @override
  String toString() {
    return "$weekDay-$target-$score";
  }

  double get completedPercent {
    if (target == 0) {
      return 0;
    }
    if (target <= score) {
      return 1;
    }
    return score / target;
  }

  bool get isCompleted {
    return completedPercent == 1;
  }

  String get dayName => dayNames[weekDay - 1];
}