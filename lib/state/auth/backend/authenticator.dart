import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:instagram_clone_app/state/auth/constants/constants.dart';
import 'package:instagram_clone_app/state/auth/models/auth_result.dart';
import 'package:instagram_clone_app/state/posts/typedefs/user_id.dart';

///
/// Contain all app authentication business logic.
///
class Authenticator {
  UserId? get userId => FirebaseAuth.instance.currentUser?.uid;
  bool get isAlreadyLoggedIn => userId != null;
  String get displayName => FirebaseAuth.instance.currentUser?.displayName ?? '';
  String? get email => FirebaseAuth.instance.currentUser?.email;

  const Authenticator();

  ///
  /// Sign out with all possible methods.
  ///
  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
  }

  ///
  /// Login with Facebook.
  ///
  Future<AuthResult> loginWithFacebook() async {
    // show user Facebook login dialog for interaction
    final loginResult = await FacebookAuth.instance.login();
    // get token from result
    final token = loginResult.accessToken?.token;
    if (token == null) {
      // user has aborted the logging in process
      return AuthResult.aborted;
    }
    // exchange token with OAuth credentials
    final oAuthCredentials = FacebookAuthProvider.credential(token);
    // try to sign in with oauthCredentials
    try {
      await FirebaseAuth.instance.signInWithCredential(oAuthCredentials);
      return AuthResult.success;
    } on FirebaseAuthException catch (e) {
      // for Federated authentication use case:
      // allow user login with same email address using Google or Facebook
      // Facebook specific. If you do not do this, you will be not able to login
      // to Facebook with same email, which you already logged in to Google.
      final email = e.email;
      final credential = e.credential;
      if (e.code == Constants.accountExistsWithDifferentCredential &&
        email != null &&
        credential != null)
      {
        final providers
          = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
        if (providers.contains(Constants.googleCom)) {
          await loginWithGoogle();
          FirebaseAuth.instance.currentUser?.linkWithCredential(credential);
        }
        return AuthResult.success;
      }
      return AuthResult.failure;
    }
  }

  ///
  /// Login with Google.
  ///
  Future<AuthResult> loginWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(scopes: [
      Constants.emailScope,
    ]);
    final signInAccount = await googleSignIn.signIn();
    if (signInAccount == null) {
      return AuthResult.aborted;
    }
    final googleAuth = await signInAccount.authentication;
    final oAuthCredentials = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    try {
      await FirebaseAuth.instance.signInWithCredential(oAuthCredentials);
      return AuthResult.success;
    } catch (e) {
      return AuthResult.failure;
    }
  }
}