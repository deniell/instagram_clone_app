import 'dart:typed_data' show Uint8List;
import 'package:flutter/material.dart' as material show Image;
import 'package:instagram_clone_app/state/image_upload/extensions/get_image_aspect_ratio.dart';

///
/// Extension on Uint8List, which help us to get image aspect ratio from image
/// in Uint8List format.
///
extension GetImageDataAspectRatio on Uint8List {
  Future<double> getAspectRatio() {
    final image = material.Image.memory(this);
    return image.getAspectRatio();
  }
}
