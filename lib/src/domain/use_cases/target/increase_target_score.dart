import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';

class IncreaseTargetScore implements UseCase<Unit, int> {
  IncreaseTargetScore({required TargetRepository targetRepository}) : _targetRepository = targetRepository;

  final TargetRepository _targetRepository;

  @override
  Future<Either<Failure, Unit>> call(int params) async {
    final targetResult = await _targetRepository.getStorageTarget();
    return targetResult.fold((l) => left(l), (target) async {
      final weekday = DateTime.now().weekday;
      final itemsResult = await _targetRepository.getWeekTargetData();
      return itemsResult.fold((l) => left(l), (items) async {
        final item = items.firstWhere((element) => element.weekDay == weekday);
        item.score += params;
        item.target = 30;
        if(item.completedPercent >= 1) {
          await _updateStreak(target);
        }
        target.weekTargetData = items.map((e) => e.toString()).join(",");
        return _targetRepository.saveStorageTarget(target);
      });
    });
  }

  Future<void> _updateStreak(StorageTarget storageTarget) async {
    final now = DateTime.now();
    final lastCompletedTimeStamp = storageTarget.lastCompletedTargetDate;
    final lastCompletedDate = DateTime.fromMillisecondsSinceEpoch(lastCompletedTimeStamp);

    if(DateUtils.isSameDay(now, lastCompletedDate)) {
      return;
    }
    final diff = now.difference(lastCompletedDate).inHours;
    final longestStreakNumber = storageTarget.longestStreakNumber;

    final streakNumber = storageTarget.streakNumber;
    final isBreakStreak = diff > 48;
    final nextStreakNumber = isBreakStreak ? 1 : streakNumber + 1;
    if(nextStreakNumber > longestStreakNumber) {
      storageTarget.longestStreakNumber = nextStreakNumber;
    }
    storageTarget.streakNumber = nextStreakNumber;
    storageTarget.lastCompletedTargetDate = DateTime.now().millisecondsSinceEpoch;
    await _targetRepository.saveStorageTarget(storageTarget);
  }
}
