
import 'package:app_core/app_core.dart';
import 'package:fpdart/fpdart.dart';

class SyncShowAdsLimit implements UseCase<Unit, String> {
  SyncShowAdsLimit({required this.sharedPreferencesHelper, required this.firebaseHelper});

  final CoreSharedPreferencesHelper sharedPreferencesHelper;
  final FirebaseHelper firebaseHelper;

  @override
  Future<Either<Failure, Unit>> call(String params) async {
    var limit = await firebaseHelper.getVersionConfig(params);
    if(limit == 0) limit = 30;
    await sharedPreferencesHelper.saveShowAdsLimit(limit);
    return const Right(unit);
  }
}
