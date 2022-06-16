import 'package:desafio_eduq/services/translate/translator_get.dart';
import 'package:desafio_eduq/theme/colors_theme.dart';
import 'package:desafio_eduq/theme/styles_theme.dart';
import 'package:flutter/material.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class TextStrokeTheme extends StatelessWidget {
  final String text;
  final double fontSize;
  final double strokeWidth;
  final WidgetRestingEffects? restingEffects;
  const TextStrokeTheme({
    Key? key,
    required this.text,
    this.fontSize = 16,
    this.strokeWidth = 5,
    this.restingEffects,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WidgetAnimator(
      atRestEffect: restingEffects,
      child: StrokeText(
        text: Translator.get(text),
        textStyle: StylesTheme.thematicFont.copyWith(
          fontSize: fontSize,
          color: ColorsTheme.fontThemeColor,
        ),
        strokeColor: ColorsTheme.fontThemeStrokeColor,
        strokeWidth: strokeWidth,
      ),
    );
  }
}
