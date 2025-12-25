import 'package:app_core/app_core.dart';

class SetTargetCompleted implements UseCase<Unit, NoParams> {
  SetTargetCompleted({required TargetRepository targetRepository}) : _targetRepository = targetRepository;

  final TargetRepository _targetRepository;

  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    final getStorageTargetResult = await _targetRepository.getStorageTarget();
    return getStorageTargetResult.fold((l) => left(l), (target) async {
      target.lastCompletedTargetDate = DateTime.now().millisecondsSinceEpoch;
      return _targetRepository.saveStorageTarget(target);
    });
  }
}
