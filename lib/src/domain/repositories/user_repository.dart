import 'package:app_core/app_core.dart';

enum AuthType {
  google,
  apple,
  anonymous,
}

abstract class UserRepository {
  Future<Either<Failure, CoreUser>> login(AuthType authType);
  Future<Either<Failure, CoreUser>> getUser();
  Future<Either<Failure, Unit>> linkAccount(AuthType authType);
  Future<Either<Failure, Unit>> logout();
  Future<Either<Failure, Unit>> deleteUser();
}