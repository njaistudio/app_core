import 'package:app_core/app_core.dart';
import 'package:app_core/src/data/storage/storage_target.dart';
import 'package:app_core/src/domain/entities/target_item.dart';
import 'package:fpdart/fpdart.dart';

abstract class TargetRepository {
  Future<Either<Failure, List<int>>> getAvailableTargets();
  Future<Either<Failure, StorageTarget>> getStorageTarget();
  Future<Either<Failure, Unit>> saveStorageTarget(StorageTarget target);
  Future<Either<Failure, int>> getCurrentTarget();
  Future<Either<Failure, List<TargetItem>>> getWeekTargetData();
}
