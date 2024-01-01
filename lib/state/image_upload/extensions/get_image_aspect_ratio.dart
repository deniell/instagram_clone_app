import 'dart:async' show Completer;

import 'package:flutter/material.dart' as material
    show Image, ImageConfiguration, ImageStreamListener;

///
/// Extension on Material Image, which helps to compute image aspect ratio.
///
extension GetImageAspectRatio on material.Image {
  Future<double> getAspectRatio() async {
    final completer = Completer<double>();
    image.resolve(const material.ImageConfiguration()).addListener(
      material.ImageStreamListener(
        (imageInfo, synchronousCall) {
          final aspectRatio = imageInfo.image.width / imageInfo.image.height;
          imageInfo.image.dispose();
          completer.complete(aspectRatio);
        },
      ),
    );
    return completer.future;
  }
}
