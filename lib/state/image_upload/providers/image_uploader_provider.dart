import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/state/image_upload/notifiers/image_upload_notifier.dart';
import 'package:instagram_clone_app/state/image_upload/typedefs/is_loading.dart';

///
/// Provider, which notify listeners of [ImageUploadNotifier] about
/// [IsLoading] state.
///
final imageUploaderProvider =
    StateNotifierProvider<ImageUploadNotifier, IsLoading>(
  (ref) => ImageUploadNotifier(),
);
