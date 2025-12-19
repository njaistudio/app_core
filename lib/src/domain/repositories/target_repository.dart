import 'package:app_core/app_core.dart';
import 'package:fpdart/fpdart.dart';

abstract class TargetRepository {
  Future<Either<Failure, List<int>>> getAvailableTargets();
  Future<Either<Failure, StorageTarget>> getStorageTarget({bool fromCloud = false});
  Future<Either<Failure, Unit>> saveStorageTarget(StorageTarget target);
  Future<Either<Failure, int>> getCurrentTarget();
  Future<Either<Failure, List<TargetItem>>> getWeekTargetData();
}
