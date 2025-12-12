import 'package:app_core/app_core.dart';
import 'package:app_core/src/data/user_repository_impl.dart';
import 'package:app_core/src/data/services/auth_service.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

class CoseServiceLocator {
  final String deleteAccountUrl;

  CoseServiceLocator({required this.deleteAccountUrl});

  void setup() {
    getIt.registerLazySingleton<AuthService>(() => AuthService(deleteAccountUrl: deleteAccountUrl));
    getIt.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(authService: getIt()));
  }
}