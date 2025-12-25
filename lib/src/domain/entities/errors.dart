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

class BuyProductError extends Failure {
  const BuyProductError({String? message}) : super(message ?? "Something wrong! Unable to process payment!");
}

class RestorePurchaseError extends Failure {
  const RestorePurchaseError({String? message}) : super(message ?? "Your Account ID does not match. Please log in with the correct account to do this!");
}