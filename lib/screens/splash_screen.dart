import 'package:desafio_eduq/components/animations/lottie_animation_widget.dart';
import 'package:desafio_eduq/components/text/text_stroke_theme_widget.dart';
import 'package:desafio_eduq/services/routes/app_routes_name.dart';
import 'package:desafio_eduq/theme/colors_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  getData() async {
    await Future.delayed(Duration(seconds: 2)).then((value) async {
      Get.offAndToNamed(RouteName.home);
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: ColorsTheme.beige,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LottieAnimationWidget(assetName: 'morty_dance_loader'),
              SizedBox(
                height: 30,
              ),
              TextStrokeTheme(
                text: 'Loading',
                fontSize: 40,
                strokeWidth: 5,
                restingEffects: WidgetRestingEffects.swing(
                  effectStrength: 2,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
