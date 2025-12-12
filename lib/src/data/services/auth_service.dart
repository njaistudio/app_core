import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String deleteAccountUrl;

  AuthService({required this.deleteAccountUrl});

  Future<bool> googleLogin() async {
    try {
      final authCredential = await _getGoogleAuthCredential();
      final credential = GoogleAuthProvider.credential(
        accessToken: authCredential.accessToken,
        idToken: authCredential.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> guestLogin() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> appleLogin({AuthorizationCredentialAppleID? authorizationCredentialAppleID}) async {
    try {
      AuthorizationCredentialAppleID appleCredential;
      if (authorizationCredentialAppleID != null) {
        appleCredential = authorizationCredentialAppleID;
      } else {
        appleCredential = await _getAppleIDCredential();
      }

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: generateNonce(),
        accessToken: appleCredential.authorizationCode,
      );

      final authResult = await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      final firebaseUser = authResult.user;

      if (appleCredential.email != null) {
        final userEmail = '${appleCredential.email}';
        await firebaseUser?.verifyBeforeUpdateEmail(userEmail);
      }

      if (appleCredential.familyName != null) {
        final displayName = '${appleCredential.givenName} ${appleCredential.familyName}';
        await firebaseUser?.updateDisplayName(displayName);
      }

      return true;
    } catch (exception) {
      return false;
    }
  }

  Future logout() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<bool> deleteAccount() async {
    if (FirebaseAuth.instance.currentUser?.isAnonymous == true) {
      await logout();
      return true;
    }

    final providerData = FirebaseAuth.instance.currentUser?.providerData.first;
    final providerId = providerData?.providerId;

    if (providerId == "apple.com") {
      try {
        final appleCredential = await _getAppleIDCredential();
        if (appleCredential.identityToken == null) {
          return false;
        }
        await appleLogin(authorizationCredentialAppleID: appleCredential);

        final refreshResult = await http.get(Uri.parse("$deleteAccountUrl/getRefreshToken?code=${appleCredential.authorizationCode}"));
        var refreshToken = refreshResult.body;
        await http.get(Uri.parse("$deleteAccountUrl/revokeToken?refresh_token=$refreshToken"));
      } catch (_) {
        return false;
      }
    } else if (providerId == "google.com") {
      try {
        final isSuccess = await googleLogin();
        if (!isSuccess) {
          return isSuccess;
        }
      } catch (_) {
        return false;
      }
    }

    await FirebaseAuth.instance.currentUser?.delete();
    return true;
  }

  Future<OAuthCredential> _getGoogleAuthCredential() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final authCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return authCredential;
  }

  Future<AuthorizationCredentialAppleID> _getAppleIDCredential() async {
    final appleCredential = await SignInWithApple.getAppleIDCredential(scopes: [
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName,
    ]);
    return appleCredential;
  }
}