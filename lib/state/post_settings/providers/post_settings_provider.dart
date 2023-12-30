import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/state/post_settings/models/post_settings.dart';
import 'package:instagram_clone_app/state/post_settings/notifiers/post_settings_notifier.dart';

///
/// Provider, which let UI know, when post settings are updated.
///
final postSettingsProvider =
    StateNotifierProvider<PostSettingsNotifier, Map<PostSetting, bool>>(
  (ref) => PostSettingsNotifier(),
);
