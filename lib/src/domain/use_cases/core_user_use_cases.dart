import 'package:app_core/src/domain/use_cases/user/delete_user_use_case.dart';
import 'package:app_core/src/domain/use_cases/user/get_user_use_case.dart';
import 'package:app_core/src/domain/use_cases/user/is_anonymous_use_case.dart';
import 'package:app_core/src/domain/use_cases/user/is_logged_in_use_case.dart';
import 'package:app_core/src/domain/use_cases/user/link_account_use_case.dart';
import 'package:app_core/src/domain/use_cases/user/login_use_case.dart';
import 'package:app_core/src/domain/use_cases/user/logout_use_case.dart';

class CoreUserUseCases {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final LinkAccountUseCase linkAccountUseCase;
  final GetUserUseCase getUserUseCase;
  final DeleteUserUseCase deleteUserUseCase;
  final IsLoggedInUseCase isLoggedInUseCase;
  final IsAnonymousUseCase isAnonymousUseCase;

  CoreUserUseCases({
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.linkAccountUseCase,
    required this.getUserUseCase,
    required this.deleteUserUseCase,
    required this.isLoggedInUseCase,
    required this.isAnonymousUseCase,
  });
}