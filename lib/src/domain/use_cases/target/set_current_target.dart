import 'package:app_core/app_core.dart';
import 'package:app_core/src/domain/repositories/target_repository.dart';
import 'package:fpdart/fpdart.dart';

class SetCurrentTarget implements UseCase<Unit, int> {
  SetCurrentTarget({required TargetRepository targetRepository}) : _targetRepository = targetRepository;

  final TargetRepository _targetRepository;

  @override
  Future<Either<Failure, Unit>> call(int params) async {
    final storageTargetResult = await _targetRepository.getStorageTarget();

    return storageTargetResult.fold((l) => left(l), (storageTarget) async {
      final weekday = DateTime.now().weekday;
      final getWeekTargetDataResult = await _targetRepository.getWeekTargetData();
      return getWeekTargetDataResult.fold((l) => left(l), (items) async {
        final item = items.firstWhere((element) => element.weekDay == weekday);
        final oldCompleted = item.isCompleted;
        item.target = params;
        final newCompleted = item.isCompleted;

        if(oldCompleted && !newCompleted) {
          storageTarget.streakNumber -= 1;
          final lastCompletedTargetDate = DateTime.fromMillisecondsSinceEpoch(storageTarget.lastCompletedTargetDate);

          if(storageTarget.streakNumber <= 0) {
            storageTarget.lastCompletedTargetDate = 0;
          } else {
            storageTarget.lastCompletedTargetDate = lastCompletedTargetDate.subtract(const Duration(days: 1)).millisecondsSinceEpoch;
          }
        }

        if(!oldCompleted && newCompleted) {
          storageTarget.streakNumber += 1;
          storageTarget.lastCompletedTargetDate = DateTime.now().millisecondsSinceEpoch;

        }

        storageTarget.weekTargetData = items.map((e) => e.toString()).join(",");
        storageTarget.currentTarget = params;
        return _targetRepository.saveStorageTarget(storageTarget);
      });
    });
  }
}
