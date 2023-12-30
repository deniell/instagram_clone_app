import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/state/auth/providers/auth_state_provider.dart';
import 'package:instagram_clone_app/state/image_upload/typedefs/is_loading.dart';

///
/// Provider, which let UI know when there is something loading in process.
///
final isLoadingProvider = Provider<IsLoading>((ref) {
  final authState = ref.watch(authStateProvider);

  return authState.isLoading;
});