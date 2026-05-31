import 'package:app_core/app_core.dart';

class GetWeekTargetData implements UseCase<List<TargetItem>, NoParams> {
  GetWeekTargetData({required TargetRepository targetRepository}) : _targetRepository = targetRepository;

  final TargetRepository _targetRepository;

  @override
  Future<Either<Failure, List<TargetItem>>> call(NoParams params) async {
    final targetsResult = await _targetRepository.getWeekTargetData();

    int needAddFromV1Error = 0;
    final versionV1TargetResult = await _targetRepository.getStorageTarget(fromCloud: false, version: "_v1");
    versionV1TargetResult.fold((l) => null, (v1Target) {
      needAddFromV1Error = v1Target.longestStreakNumber;
    });
    if(needAddFromV1Error > 0) {
      final currentTargetResult = await _targetRepository.getStorageTarget(fromCloud: false);
      currentTargetResult.fold((l) => null, (target) async {
        target.streakNumber += needAddFromV1Error;
        if(target.streakNumber > target.longestStreakNumber) {
          target.longestStreakNumber = target.streakNumber;
        }
        target.lastCompletedTargetDate = DateTime.now().subtract(Duration(days: 1)).millisecondsSinceEpoch;
        await _targetRepository.saveStorageTarget(target);
      });
      await _targetRepository.removeOldTarget("targetKey_v1");
    }

    return targetsResult.fold((l) => left(l), (targets) {
      final currentWeekDay = DateTime.now().weekday;
      targets.firstWhere((element) => element.weekDay == currentWeekDay).isHighlight = true;
      return Either.right(targets);
    });
  }
}
