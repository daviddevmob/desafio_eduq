import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieAnimationWidget extends StatelessWidget {
  final String assetName;
  final double frameRate;
  final bool animate;
  final bool repete;
  final Function(LottieComposition)? onLoaded;
  const LottieAnimationWidget({
    Key? key,
    required this.assetName,
    this.frameRate = 60,
    this.animate = true,
    this.repete = true,
    this.onLoaded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/lottie_animations/${assetName}.json',
      frameRate: FrameRate(60),
      animate: true,
      repeat: true,
      onLoaded: onLoaded,
    );
  }
}
