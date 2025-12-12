import 'package:app_core/app_core.dart';
import 'package:app_core/src/domain/repositories/target_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetLongestStreakNumber implements UseCase<int, NoParams> {
  GetLongestStreakNumber({required TargetRepository targetRepository}) : _targetRepository = targetRepository;

  final TargetRepository _targetRepository;

  @override
  Future<Either<Failure, int>> call(NoParams params) async {
    final target = await _targetRepository.getStorageTarget();
    return target.fold((l) => left(l), (r) => right(r.longestStreakNumber));
  }
}
