import 'package:app_core/app_core.dart';
import 'package:fpdart/fpdart.dart';

enum AuthType {
  google,
  apple,
  anonymous,
}

abstract class UserRepository {
  Future<Either<Failure, User>> login(AuthType authType);
  Future<Either<Failure, User>> getUser();
  Future<Either<Failure, User>> linkAccount();
  Future<Either<Failure, Unit>> logout();
  Future<Either<Failure, Unit>> deleteUser();
}