import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/state/image_upload/typedefs/is_loading.dart';

class ImageUploadNotifier extends StateNotifier<IsLoading> {
  ImageUploadNotifier() : super(false);

  set isLoading(bool value) => state = value;
}