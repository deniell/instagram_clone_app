import 'dart:io';
import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/state/image_upload/constants/constants.dart';
import 'package:instagram_clone_app/state/image_upload/exceptions/could_not_build_thumbnail_exception.dart';
import 'package:instagram_clone_app/state/image_upload/models/file_type.dart';
import 'package:instagram_clone_app/state/image_upload/typedefs/is_loading.dart';
import 'package:instagram_clone_app/state/post_settings/models/post_settings.dart';
import 'package:instagram_clone_app/state/posts/typedefs/user_id.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ImageUploadNotifier extends StateNotifier<IsLoading> {
  ImageUploadNotifier() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> upload({
    required File file,
    required FileType fileType,
    required String message,
    required Map<PostSetting, bool> postSettings,
    required UserId userId,
  }) async {
    isLoading = true;

    late Uint8List thumbnailUint8List;

    switch (fileType) {
      case FileType.image:
        final fileAsImage = img.decodeImage(file.readAsBytesSync());
        if (fileAsImage == null) {
          isLoading = false;
          throw const CouldNotBuildThumbnailException();
        }
        // create thumbnail
        final thumbnail = img.copyResize(
          fileAsImage,
          width: Constants.imageThumbnailWidth,
        );
        // get thumbnail data
        final thumbnailData = img.encodeJpg(thumbnail);
        thumbnailUint8List = Uint8List.fromList(thumbnailData);
        break;
      case FileType.video:
        final thumb = await VideoThumbnail.thumbnailData(
          video: file.path,
          imageFormat: ImageFormat.JPEG,
          maxHeight: Constants.videoThumbnailMaxHeight,
          quality: Constants.videoThumbnailQuality,
        );
        if (thumb == null) {
          isLoading = false;
          throw const CouldNotBuildThumbnailException();
        } else {
          thumbnailUint8List = thumb;
        }
        break;
    }

    return false;
  }
}
