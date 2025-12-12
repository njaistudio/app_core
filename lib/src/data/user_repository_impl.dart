import 'package:app_core/app_core.dart';
import 'package:app_core/src/data/services/firebase_helper.dart';
import 'package:firebase_auth/firebase_auth.dart' as FA;
import 'package:app_core/src/domain/entities/errors.dart';
import 'package:app_core/src/data/services/auth_service.dart';
import 'package:fpdart/fpdart.dart';

class UserRepositoryImpl implements UserRepository {
  final AuthService authService;
  final FirebaseHelper _firebaseHelper = FirebaseHelper();

  UserRepositoryImpl({required this.authService});

  @override
  Future<Either<Failure, Unit>> deleteUser() async {
    bool deleteUserSuccess = await authService.deleteAccount();
    if(!deleteUserSuccess) {
      return Left(DeleteAccountError());
    }
    return const Right(unit);
  }

  @override
  Future<Either<Failure, User>> getUser() async {
    final firebaseUser = _firebaseHelper.currentUser;
    if(firebaseUser == null) {
      return Left(NoUserError());
    }
    return Either.right(User(id: firebaseUser.uid, email: firebaseUser.email, name: firebaseUser.displayName, avatar: firebaseUser.photoURL));
  }

  @override
  Future<Either<Failure, Unit>> linkAccount(AuthType authType) async {
    String anonymousId = _firebaseHelper.currentUser?.uid ?? DateTime.now().toIso8601String();
    final anonymousData = await _allUserData();
    bool isLoginSuccess = false;
    switch(authType) {
      case AuthType.google:
        isLoginSuccess = await authService.googleLogin();
        break;
      case AuthType.apple:
        isLoginSuccess = await authService.appleLogin();
        break;
      case AuthType.anonymous:
        isLoginSuccess = true;
        break;
    }
    if(!isLoginSuccess) {
      return Either.left(LinkAccountError());
    }

    FA.User? socialUser = _firebaseHelper.currentUser;
    String socialId = socialUser?.uid ?? DateTime.now().toIso8601String();
    String socialEmail = socialUser?.email ?? DateTime.now().toIso8601String();
    final socialData = await _allUserData();

    await _saveBackupLinkAccount(
      anonymousId,
      anonymousData,
      socialId,
      socialEmail,
      socialData,
    );

    await _saveAllUserData(anonymousData);
    return Either.right(unit);
  }

  @override
  Future<Either<Failure, User>> login(AuthType authType) async {
    bool isLoginSuccess = false;
    switch (authType) {
      case AuthType.google:
        isLoginSuccess = await authService.googleLogin();
        break;
      case AuthType.apple:
        isLoginSuccess = await authService.appleLogin();
        break;
      case AuthType.anonymous:
        isLoginSuccess = await authService.guestLogin();
        break;
    }
    if(!isLoginSuccess) {
      return Left(LoginError());
    }
    final getUserResult = await getUser();
    return getUserResult.fold(
          (failure) => Left(failure),
          (user) => Right(user),
    );
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    await authService.logout();
    return const Right(unit);
  }

  Future<Map> _allUserData() async {
    var currentUser = _firebaseHelper.currentUser;
    var userDataSnapShoot = await _firebaseHelper.getDatabaseSnapshot("users/${currentUser?.uid}");
    return userDataSnapShoot.value as Map? ?? {};
  }

  Future _saveAllUserData(Map data) async {
    var currentUser = _firebaseHelper.currentUser;
    await _firebaseHelper.setDatabaseValue("users/${currentUser?.uid}", data);
  }

  Future _saveBackupLinkAccount(String anonymousId, Map<dynamic, dynamic> anonymousData, String socialId, String socialEmail, Map<dynamic, dynamic> socialData,) async {
    final data = {
      "anonymousId": anonymousId,
      "anonymousData": anonymousData,
      "socialId": socialId,
      "socialEmail": socialEmail,
      "socialData": socialData,
    };
    await _firebaseHelper.setDatabaseValue("link_accounts/$anonymousId-$socialId", data);
  }
}
