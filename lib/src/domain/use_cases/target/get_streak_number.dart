import 'package:app_core/app_core.dart';

class GetStreakNumber implements UseCase<int, NoParams> {
  GetStreakNumber({required TargetRepository targetRepository}) : _targetRepository = targetRepository;

  final TargetRepository _targetRepository;

  @override
  Future<Either<Failure, int>> call(NoParams params) async {
    final targetResult = await _targetRepository.getStorageTarget();
    return targetResult.fold((l) => left(l), (target) {
      final now = DateTime.now();
      final lastCompletedDate = DateTime.fromMillisecondsSinceEpoch(target.lastCompletedTargetDate);
      final diff = now.difference(lastCompletedDate).inHours;

      final isBreakStreak = diff > 48;
      return Either.right(isBreakStreak ? 0 : target.streakNumber);
    });
  }
}
