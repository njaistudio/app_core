import 'package:app_core/app_core.dart';

class UserUseCases {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final LinkAccountUseCase linkAccountUseCase;
  final GetUserUseCase getUserUseCase;
  final DeleteUserUseCase deleteUserUseCase;
  final IsLoggedInUseCase isLoggedInUseCase;
  final IsAnonymousUseCase isAnonymousUseCase;

  UserUseCases({
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.linkAccountUseCase,
    required this.getUserUseCase,
    required this.deleteUserUseCase,
    required this.isLoggedInUseCase,
    required this.isAnonymousUseCase,
  });
}