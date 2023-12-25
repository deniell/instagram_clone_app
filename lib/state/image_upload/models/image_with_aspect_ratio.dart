import 'package:flutter/material.dart';

///
/// Represents Image with aspect ratio entity.
///
@immutable
class ImageWithAspectRatio {
  final Image image;
  final double aspectRatio;

  const ImageWithAspectRatio({
    required this.image,
    required this.aspectRatio,
  });
}