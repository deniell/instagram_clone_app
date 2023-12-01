import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/state/auth/models/auth_state.dart';
import 'package:instagram_clone_app/state/auth/notifiers/auth_state_notifier.dart';

///
/// Self contained StateNotifierProvider (does not use "ref" to access any other
/// providers).
/// Expose single instance of AuthStateNotifier() to the app.
/// Listener of AuthStateNotifier events of type AuthState
///
final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
    (_) => AuthStateNotifier(),
);
