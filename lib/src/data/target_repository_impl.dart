import 'dart:convert';

import 'package:app_core/src/clean/error/failures.dart';
import 'package:app_core/src/data/services/firebase_helper.dart';
import 'package:app_core/src/data/storage/core_shared_preferences_helper.dart';
import 'package:app_core/src/data/storage/storage_target.dart';
import 'package:app_core/src/domain/entities/target_item.dart';
import 'package:app_core/src/domain/repositories/target_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:isoweek/isoweek.dart';

class TargetRepositoryImpl implements TargetRepository {
  TargetRepositoryImpl({
    required this.sharedPreferencesHelper,
    required this.firebaseHelper,
  });

  final CoreSharedPreferencesHelper sharedPreferencesHelper;
  final FirebaseHelper firebaseHelper;

  @override
  Future<Either<Failure, List<int>>> getAvailableTargets() async {
    return Either.right([30, 40, 50]);
  }

  @override
  Future<Either<Failure, int>> getCurrentTarget() async {
    var getAvailableTargetsResult = await getAvailableTargets();
    return getAvailableTargetsResult.fold((l) => left(l), (targets) async {
      var target = await sharedPreferencesHelper.getTarget();
      if(target.currentTarget == 0) {
        target.currentTarget = targets.first;
        await saveStorageTarget(target);
      }
      return Either.right(target.currentTarget);
    });
  }

  @override
  Future<Either<Failure, StorageTarget>> getStorageTarget() async {
    final target = await sharedPreferencesHelper.getTarget();
    return Either.right(target);
  }

  @override
  Future<Either<Failure, List<TargetItem>>> getWeekTargetData() async {
    final getStorageTargetResult = await getStorageTarget();

    return getStorageTargetResult.fold((l) => left(l), (target) async {
      final currentWeek = Week.current().weekNumber;
      final currentTargetWeek = target.currentTargetWeek;
      final weekTargetData = target.weekTargetData;
      if(weekTargetData.isEmpty || currentWeek != currentTargetWeek) {
        target.currentTargetWeek = currentWeek;
        List<TargetItem> newWeekTargetData = [1,2,3,4,5,6,7].map((day) => TargetItem(day, 0, 0)).toList();
        target.weekTargetData = newWeekTargetData.map((e) => e.toString()).join(",");
        await saveStorageTarget(target);
        return Either.right(newWeekTargetData);
      }
      return Either.right(weekTargetData.split(",").map((e) => TargetItem.fromString(e)).toList());
    });
  }

  @override
  Future<Either<Failure, Unit>> saveStorageTarget(StorageTarget target) async {
    var currentUser = firebaseHelper.currentUser;
    firebaseHelper.updateDatabaseValue("users/${currentUser?.uid}", {
      "target": json.encode(target.toJson()),
    });
    sharedPreferencesHelper.setTarget(target);
    return Either.right(unit);
  }
}
