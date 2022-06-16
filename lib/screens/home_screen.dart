import 'package:desafio_eduq/components/animations/lottie_animation_widget.dart';
import 'package:desafio_eduq/components/card/character_card_widget.dart';
import 'package:desafio_eduq/services/translate/translator_get.dart';
import 'package:desafio_eduq/theme/colors_theme.dart';
import 'package:desafio_eduq/theme/styles_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/others/gesture_scale_tap_widget.dart';
import '../components/search/search_fiel_widget.dart';
import '../controllers/home_controller.dart';
import '../models/result_search_characters_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorsTheme.grey,
        appBar: AppBar(
          backgroundColor: ColorsTheme.grey,
          title: Text(
            Translator.get('Welcome'),
            style: StylesTheme.h2.copyWith(
              color: ColorsTheme.blue,
              fontSize: 18,
            ),
          ),
          centerTitle: true,
          actions: [
            GestureScaleTap(
              scaleMinValue: 1.2,
              child: Icon(
                Icons.settings,
                color: ColorsTheme.blue,
              ),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            height: Get.height,
            width: Get.width,
            child: Obx(() {
              if (!homeController.initLoadFinish.value) {
                return Center(
                  child: Container(
                    height: 350,
                    width: 250,
                    child: LottieAnimationWidget(assetName: 'loading'),
                  ),
                );
              }
              return Column(
                children: [
                  SearchFieldWidget(),
                  Obx(() {
                    if (homeController.loadScreen.value) {
                      return Expanded(
                        child: Center(
                          child: Container(
                            height: 350,
                            width: 250,
                            child: LottieAnimationWidget(assetName: 'loading'),
                          ),
                        ),
                      );
                    }

                    if (homeController.searchCharacters.value.info.count ==
                        null) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            Translator.get(
                              "There's nothing with the name @value",
                              params: {
                                "value":
                                    homeController.nameController.value.text,
                              },
                            ),
                            textAlign: TextAlign.center,
                            style: StylesTheme.bodyText.copyWith(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          Container(
                            height: 350,
                            width: 250,
                            child:
                                LottieAnimationWidget(assetName: 'morty_cry'),
                          ),
                        ],
                      );
                    }
                    return Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 1,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: homeController
                              .searchCharacters.value.results.length,
                          itemBuilder: (BuildContext ctx, index) {
                            Character current = homeController
                                .searchCharacters.value.results[index];
                            return CharacterCardWidget(character: current);
                          },
                        ),
                      ),
                    );
                  }),
                  Obx(() {
                    if (homeController.searchCharacters.value.info.count ==
                        null) {
                      return Container(
                        height: 40,
                        width: Get.width / 3,
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                      );
                    }
                    return Container(
                      height: 40,
                      width: Get.width / 3,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            (homeController.searchCharacters.value.info.count! /
                                    20)
                                .ceil(),
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: 10,
                          );
                        },
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              homeController.page.value = (index + 1);
                              await homeController.getC();
                            },
                            child: Text(
                              "${index + 1}",
                              style: homeController.page.value == (index + 1)
                                  ? StylesTheme.h1.copyWith(
                                      color: ColorsTheme.fontThemeColor,
                                      fontSize: 14,
                                    )
                                  : StylesTheme.bodyText.copyWith(
                                      color: ColorsTheme.blue,
                                      fontSize: 14,
                                    ),
                            ),
                          );
                        },
                      ),
                    );
                  }),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
