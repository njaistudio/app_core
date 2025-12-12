import 'package:app_core/app_core.dart';

class NoUserError extends Failure {
  const NoUserError() : super("User is not found.");
}

class LoginError extends Failure {
  const LoginError({String? message}) : super(message ?? "Login failed.");
}

class DeleteAccountError extends Failure {
  const DeleteAccountError({String? message}) : super(message ?? "Delete account failed.");
}

class LinkAccountError extends Failure {
  const LinkAccountError({String? message}) : super(message ?? "Link account failed.");
}