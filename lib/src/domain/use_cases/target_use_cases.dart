import 'package:app_core/src/domain/use_cases/target/get_longest_streak_number.dart';
import 'package:app_core/src/domain/use_cases/target/get_streak_number.dart';
import 'package:app_core/src/domain/use_cases/target/get_week_target_data.dart';
import 'package:app_core/src/domain/use_cases/target/increase_target_score.dart';
import 'package:app_core/src/domain/use_cases/target/set_current_target.dart';
import 'package:app_core/src/domain/use_cases/target/set_target_completed.dart';
import 'package:app_core/src/domain/use_cases/target/sync_targets.dart';

class TargetUseCases {
  final GetStreakNumber getStreakNumber;
  final GetWeekTargetData getWeekTargetData;
  final IncreaseTargetScore increaseTargetScore;
  final SetTargetCompleted setTargetCompleted;
  final GetLongestStreakNumber getLongestStreakNumber;
  final SetCurrentTarget setCurrentTarget;
  final SyncTargets syncTargets;

  TargetUseCases({
    required this.getStreakNumber,
    required this.getWeekTargetData,
    required this.increaseTargetScore,
    required this.setTargetCompleted,
    required this.getLongestStreakNumber,
    required this.setCurrentTarget,
    required this.syncTargets,
  });
}
