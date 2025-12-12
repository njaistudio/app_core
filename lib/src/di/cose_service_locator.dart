import 'package:app_core/app_core.dart';
import 'package:app_core/src/admob/ad_interstitial.dart';
import 'package:app_core/src/admob/ad_rewarded.dart';
import 'package:app_core/src/data/storage/core_shared_preferences_helper.dart';
import 'package:app_core/src/data/user_repository_impl.dart';
import 'package:app_core/src/data/services/auth_service.dart';
import 'package:app_core/src/store/purchase_helper.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

class CoseServiceLocator {
  final String deleteAccountUrl;
  final String interstitialAdAndroidUnitId;
  final String interstitialAdIOSUnitId;
  final String rewardedAdAndroidUnitId;
  final String rewardedAdIOSUnitId;
  final String appleApiKey;
  final String googleApiKey;
  final String oneYearId;
  final String lifeTimeId;

  CoseServiceLocator({
    required this.deleteAccountUrl,
    required this.interstitialAdAndroidUnitId,
    required this.interstitialAdIOSUnitId,
    required this.rewardedAdAndroidUnitId,
    required this.rewardedAdIOSUnitId,
    required this.appleApiKey,
    required this.googleApiKey,
    required this.oneYearId,
    required this.lifeTimeId,
  });

  void setup() {
    getIt.registerLazySingleton<AuthService>(() => AuthService(deleteAccountUrl: deleteAccountUrl));
    getIt.registerLazySingleton<CoreSharedPreferencesHelper>(() => CoreSharedPreferencesHelper());
    getIt.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(authService: getIt()));
    getIt.registerLazySingleton<PurchaseHelper>(() => PurchaseHelper(appleApiKey: appleApiKey, googleApiKey: googleApiKey, oneYearId: oneYearId, lifeTimeId: lifeTimeId));
    getIt.registerLazySingleton<AdInterstitial>(() => AdInterstitial(coreSharedPreferencesHelper: getIt(), purchaseHelper: getIt(), interstitialAdAndroidUnitId: interstitialAdAndroidUnitId, interstitialAdIOSUnitId: interstitialAdIOSUnitId));
    getIt.registerLazySingleton<AdRewarded>(() => AdRewarded(coreSharedPreferencesHelper: getIt(), rewardedAdAndroidUnitId: rewardedAdAndroidUnitId, rewardedAdIOSUnitId: rewardedAdIOSUnitId));
  }
}