import 'dart:io';

import 'package:flutter/foundation.dart' show immutable;
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone_app/state/image_upload/extensions/to_file.dart';

///
/// Class, which open device gallery, allow to select image/video,
/// pick selected image/video, and give us Future<File?>.
///
@immutable
class ImagePickerHelper {
  static final ImagePicker _imagePicker = ImagePicker();

  // pick image from gallery
  static Future<File?> pickImageFromGallery() =>
      _imagePicker.pickImage(source: ImageSource.gallery).toFile();

  // pick video from gallery
  static Future<File?> pickVideoFromGallery() =>
      _imagePicker.pickVideo(source: ImageSource.gallery).toFile();
}
