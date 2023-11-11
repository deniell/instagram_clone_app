import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/state/auth/backend/authenticator.dart';
import 'package:instagram_clone_app/state/auth/models/auth_result.dart';
import 'package:instagram_clone_app/state/auth/models/auth_state.dart';
import 'package:instagram_clone_app/state/posts/typedefs/user_id.dart';
import 'package:instagram_clone_app/state/user_info/backend/user_info_storage.dart';

///
/// Responsible for keeping app AuthState and emitting events of type AuthState
/// to notify listeners about the app auth state changes,
/// depends on actions, which user took on UI.
///
class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = const Authenticator();
  final _userInfoStorage = const UserInfoStorage();

  ///
  /// Constructor with default AuthState value.
  ///
  AuthStateNotifier() : super(const AuthState.unknown()) {
    if (_authenticator.isAlreadyLoggedIn) {
      // notify about state changes (emit event of type AuthState)
      state = AuthState(
        result: AuthResult.success,
        isLoading: false,
        userId: _authenticator.userId,
      );
    }
  }

  ///
  /// Log Out
  ///
  Future<void> logOut() async {
    // notify about state changes (emit event of type AuthState)
    state = state.copiedWithIsLoading(true);
    await _authenticator.logOut();
    // notify about state changes (emit event of type AuthState)
    state = const AuthState.unknown();
  }

  ///
  /// Login with Google
  ///
  Future<void> loginWithGoogle() async {
    // notify about state changes (emit event of type AuthState)
    state = state.copiedWithIsLoading(true);
    // try to login
    final result = await _authenticator.loginWithGoogle();
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(userId: userId);
    }
    // notify about state changes (emit event of type AuthState)
    state = AuthState(
      result: result,
      isLoading: false,
      userId: userId,
    );
  }

  ///
  /// Login with Facebook
  ///
  Future<void> loginWithFacebook() async {
    // notify about state changes (emit event of type AuthState)
    state = state.copiedWithIsLoading(true);
    // try to login
    final result = await _authenticator.loginWithFacebook();
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(userId: userId);
    }
    // notify about state changes (emit event of type AuthState)
    state = AuthState(
      result: result,
      isLoading: false,
      userId: userId,
    );
  }

  ///
  /// Save User Info to Firebase
  ///
  Future<void> saveUserInfo({required UserId userId}) =>
      _userInfoStorage.saveUserInfo(
        userId: userId,
        displayName: _authenticator.displayName,
        email: _authenticator.email,
      );
}
