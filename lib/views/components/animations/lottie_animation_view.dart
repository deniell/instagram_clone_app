import 'package:flutter/material.dart';
import 'package:instagram_clone_app/views/components/animations/models/lottie_animation.dart';
import 'package:lottie/lottie.dart';

///
/// Widget which help us to display a given animation
///
class LottieAnimationView extends StatelessWidget {
  final LottieAnimation animation;
  final bool repeat;
  final bool reverse;

  const LottieAnimationView({
    super.key,
    required this.animation,
    this.repeat = true,
    this.reverse = false,
  });

  @override
  Widget build(BuildContext context) => Lottie.asset(
        animation.fullPath,
        reverse: reverse,
        repeat: repeat,
      );
}
