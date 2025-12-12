import 'package:app_core/app_core.dart';
import 'package:app_core/src/admob/ad_interstitial.dart';
import 'package:app_core/src/admob/ad_rewarded.dart';
import 'package:app_core/src/data/storage/core_shared_preferences_helper.dart';
import 'package:app_core/src/data/user_repository_impl.dart';
import 'package:app_core/src/data/services/auth_service.dart';
import 'package:app_core/src/store/purchase_helper.dart';

GetIt coreGetIt = GetIt.instance;

class CoreServiceLocator {
  final String deleteAccountUrl;
  final String interstitialAdAndroidUnitId;
  final String interstitialAdIOSUnitId;
  final String rewardedAdAndroidUnitId;
  final String rewardedAdIOSUnitId;
  final String appleApiKey;
  final String googleApiKey;
  final String oneYearId;
  final String lifeTimeId;

  CoreServiceLocator({
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
    coreGetIt.registerLazySingleton<AuthService>(() => AuthService(deleteAccountUrl: deleteAccountUrl));
    coreGetIt.registerLazySingleton<CoreSharedPreferencesHelper>(() => CoreSharedPreferencesHelper());
    coreGetIt.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(authService: coreGetIt()));
    coreGetIt.registerLazySingleton<PurchaseHelper>(() => PurchaseHelper(appleApiKey: appleApiKey, googleApiKey: googleApiKey, oneYearId: oneYearId, lifeTimeId: lifeTimeId));
    coreGetIt.registerLazySingleton<AdInterstitial>(() => AdInterstitial(coreSharedPreferencesHelper: coreGetIt(), purchaseHelper: coreGetIt(), interstitialAdAndroidUnitId: interstitialAdAndroidUnitId, interstitialAdIOSUnitId: interstitialAdIOSUnitId));
    coreGetIt.registerLazySingleton<AdRewarded>(() => AdRewarded(coreSharedPreferencesHelper: coreGetIt(), rewardedAdAndroidUnitId: rewardedAdAndroidUnitId, rewardedAdIOSUnitId: rewardedAdIOSUnitId));


    coreGetIt.registerLazySingleton<LoginUseCase>(() => LoginUseCase(userRepository: coreGetIt()));
    coreGetIt.registerLazySingleton<LogoutUseCase>(() => LogoutUseCase(userRepository: coreGetIt()));
    coreGetIt.registerLazySingleton<LinkAccountUseCase>(() => LinkAccountUseCase(userRepository: coreGetIt()));
    coreGetIt.registerLazySingleton<GetUserUseCase>(() => GetUserUseCase(userRepository: coreGetIt()));
    coreGetIt.registerLazySingleton<DeleteUserUseCase>(() => DeleteUserUseCase(userRepository: coreGetIt()));
    coreGetIt.registerLazySingleton<IsLoggedInUseCase>(() => IsLoggedInUseCase(userRepository: coreGetIt()));
    coreGetIt.registerLazySingleton<IsAnonymousUseCase>(() => IsAnonymousUseCase(userRepository: coreGetIt()));


    coreGetIt.registerLazySingleton<CoreUserUseCases>(() => CoreUserUseCases(
      loginUseCase: coreGetIt(),
      logoutUseCase: coreGetIt(),
      linkAccountUseCase: coreGetIt(),
      getUserUseCase: coreGetIt(),
      deleteUserUseCase: coreGetIt(),
      isLoggedInUseCase: coreGetIt(),
      isAnonymousUseCase: coreGetIt(),
    ));

  }
}