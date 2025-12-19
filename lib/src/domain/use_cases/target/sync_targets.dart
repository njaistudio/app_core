
import 'package:app_core/app_core.dart';
import 'package:fpdart/fpdart.dart';

class SyncTargets implements UseCase<Unit, NoParams> {
  SyncTargets({required this.targetRepository});

  final TargetRepository targetRepository;

  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    final getStorageTargetResult = await targetRepository.getStorageTarget(fromCloud: true);
    return getStorageTargetResult.fold((l) => left(l), (target) async {
      return targetRepository.saveStorageTarget(target);
    });
  }
}
