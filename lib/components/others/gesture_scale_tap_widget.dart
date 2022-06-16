import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';

class GestureScaleTap extends StatelessWidget {
  final Function()? onTap;
  final Function()? onLongPress;
  final double scaleMinValue;
  final Widget? child;
  const GestureScaleTap(
      {Key? key,
      this.onTap,
      this.onLongPress,
      this.scaleMinValue = 1,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      onPressed: onTap,
      onLongPress: onLongPress,
      scaleMinValue: scaleMinValue,
      child: child,
    );
  }
}
