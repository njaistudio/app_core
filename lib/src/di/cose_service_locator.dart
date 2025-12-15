import 'package:app_core/app_core.dart';
import 'package:app_core/src/admob/ad_interstitial.dart';
import 'package:app_core/src/admob/ad_rewarded.dart';
import 'package:app_core/src/data/services/firebase_helper.dart';
import 'package:app_core/src/data/storage/core_shared_preferences_helper.dart';
import 'package:app_core/src/data/target_repository_impl.dart';
import 'package:app_core/src/data/user_repository_impl.dart';
import 'package:app_core/src/data/services/auth_service.dart';
import 'package:app_core/src/domain/repositories/target_repository.dart';
import 'package:app_core/src/domain/use_cases/target/get_available_targets.dart';
import 'package:app_core/src/domain/use_cases/target/get_current_target.dart';
import 'package:app_core/src/domain/use_cases/target/get_longest_streak_number.dart';
import 'package:app_core/src/domain/use_cases/target/get_streak_number.dart';
import 'package:app_core/src/domain/use_cases/target/get_week_target_data.dart';
import 'package:app_core/src/domain/use_cases/target/increase_target_score.dart';
import 'package:app_core/src/domain/use_cases/target/set_current_target.dart';
import 'package:app_core/src/domain/use_cases/target/set_target_completed.dart';
import 'package:app_core/src/domain/use_cases/user/delete_user_use_case.dart';
import 'package:app_core/src/domain/use_cases/user/get_user_use_case.dart';
import 'package:app_core/src/domain/use_cases/user/is_anonymous_use_case.dart';
import 'package:app_core/src/domain/use_cases/user/is_logged_in_use_case.dart';
import 'package:app_core/src/domain/use_cases/user/link_account_use_case.dart';
import 'package:app_core/src/domain/use_cases/user/login_use_case.dart';
import 'package:app_core/src/domain/use_cases/user/logout_use_case.dart';
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
    coreGetIt.registerLazySingleton<FirebaseHelper>(() => FirebaseHelper());
    coreGetIt.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(authService: coreGetIt()));
    coreGetIt.registerLazySingleton<TargetRepository>(() => TargetRepositoryImpl(sharedPreferencesHelper: coreGetIt(), firebaseHelper: coreGetIt()));
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


    coreGetIt.registerLazySingleton<GetAvailableTargets>(() => GetAvailableTargets(targetRepository: coreGetIt()));
    coreGetIt.registerLazySingleton<GetCurrentTarget>(() => GetCurrentTarget(targetRepository: coreGetIt()));
    coreGetIt.registerLazySingleton<GetStreakNumber>(() => GetStreakNumber(targetRepository: coreGetIt()));
    coreGetIt.registerLazySingleton<GetWeekTargetData>(() => GetWeekTargetData(targetRepository: coreGetIt()));
    coreGetIt.registerLazySingleton<IncreaseTargetScore>(() => IncreaseTargetScore(targetRepository: coreGetIt()));
    coreGetIt.registerLazySingleton<SetTargetCompleted>(() => SetTargetCompleted(targetRepository: coreGetIt()));
    coreGetIt.registerLazySingleton<GetLongestStreakNumber>(() => GetLongestStreakNumber(targetRepository: coreGetIt()));
    coreGetIt.registerLazySingleton<SetCurrentTarget>(() => SetCurrentTarget(targetRepository: coreGetIt()));

    coreGetIt.registerLazySingleton<TargetUseCases>(() => TargetUseCases(
      getAvailableTargets: coreGetIt(),
      getCurrentTarget: coreGetIt(),
      getStreakNumber: coreGetIt(),
      getWeekTargetData: coreGetIt(),
      increaseTargetScore: coreGetIt(),
      setTargetCompleted: coreGetIt(),
      getLongestStreakNumber: coreGetIt(),
      setCurrentTarget: coreGetIt(),
    ));
  }
}