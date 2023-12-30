import 'dart:collection';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/state/post_settings/models/post_settings.dart';

///
/// Notifier, which notify listeners about changes in PostSetting.
///
class PostSettingsNotifier extends StateNotifier<Map<PostSetting, bool>> {
  PostSettingsNotifier()
      : super(
          UnmodifiableMapView(
            {
              for (final setting in PostSetting.values) setting: true,
            },
          ),
        );

  void setSetting(
    PostSetting setting,
    bool value,
  ) {
    final existingValue = state[setting];
    if (existingValue == null || existingValue == value) {
      return;
    }
    state = Map.unmodifiable(
      Map.from(state)..[setting] = value,
    );
  }
}
