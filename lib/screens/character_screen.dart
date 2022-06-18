import 'package:cached_network_image/cached_network_image.dart';
import 'package:desafio_eduq/components/others/gesture_scale_tap_widget.dart';
import 'package:desafio_eduq/controllers/home_controller.dart';
import 'package:desafio_eduq/models/character_model.dart';
import 'package:desafio_eduq/services/routes/app_routes_name.dart';
import 'package:desafio_eduq/services/translate/translator_get.dart';
import 'package:desafio_eduq/theme/colors_theme.dart';
import 'package:desafio_eduq/theme/responsive_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/animations/lottie_animation_widget.dart';
import '../theme/styles_theme.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({Key? key}) : super(key: key);

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  final HomeController homeController = Get.find();
  late CharacterModel character;
  late String id;
  bool load = true;
  List<CharacterAlongSide> actAlongSide = [];

  getData() async {
    id = Get.parameters['id'] as String;
    character = await homeController.getSingleCharacter(id: id);
    load = false;
    character.episode.forEach((currentEp) {
      List<CharacterAlongSide> currentEpCharactersAlognSide =
          currentEp.charactersAlongSide;
      currentEpCharactersAlognSide.forEach((ch) {
        if (ch.id != character.id) {
          if (actAlongSide.firstWhereOrNull((element) => element.id == ch.id) ==
              null) {
            actAlongSide.add(ch);
          } else {
            int index =
                actAlongSide.indexWhere((element) => element.id == ch.id);
            actAlongSide[index].qty = actAlongSide[index].qty + 1;
          }
        }
      });
    });
    actAlongSide.sort(((a, b) => b.qty.compareTo(a.qty)));
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDevicePortrait =
        (Responsive.isMobile(context) && Responsive.isPortrait(context));
    return SafeArea(
      child: load
          ? Scaffold(
              backgroundColor: ColorsTheme.beige,
              body: Center(
                child: Container(
                  height: 350,
                  width: 250,
                  child: LottieAnimationWidget(assetName: 'loading'),
                ),
              ),
            )
          : Scaffold(
              backgroundColor: ColorsTheme.grey,
              appBar: AppBar(
                backgroundColor: ColorsTheme.grey,
                leading: GestureScaleTap(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.arrow_back_rounded,
                    color: ColorsTheme.brown,
                  ),
                ),
                title: Text(
                  character.name,
                  style: StylesTheme.h2.copyWith(
                    color: ColorsTheme.blue,
                    fontSize: 18,
                  ),
                ),
                centerTitle: true,
                actions: [],
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: isDevicePortrait ? 0 : 10,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: isDevicePortrait ? 0 : 10,
                      ),
                      child: Row(
                        mainAxisAlignment: isDevicePortrait
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 300,
                            width: isDevicePortrait
                                ? MediaQuery.of(context).size.width
                                : 300,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                  character.image,
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: isDevicePortrait
                                  ? BorderRadius.circular(0)
                                  : BorderRadius.circular(10),
                            ),
                          ),
                          Visibility(
                            visible: !isDevicePortrait,
                            child: InfosDesignCharacter(
                              character: character,
                              actAlongSide: actAlongSide,
                              isDevicePortrait: isDevicePortrait,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: isDevicePortrait,
                      child: InfosDesignCharacter(
                        character: character,
                        actAlongSide: actAlongSide,
                        isDevicePortrait: isDevicePortrait,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            Translator.get(
                                "All characters @value shared episodes",
                                params: {
                                  "value": character.name,
                                }),
                            style: StylesTheme.bodyText.copyWith(
                              color: ColorsTheme.fontThemeColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 16 / 5,
                              crossAxisSpacing: 1,
                              mainAxisSpacing: 1,
                            ),
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: actAlongSide.length,
                            itemBuilder: (BuildContext ctx, index) {
                              CharacterAlongSide current = actAlongSide[index];
                              return ListTile(
                                contentPadding: EdgeInsets.zero,
                                onTap: () {
                                  Get.toNamed(
                                    RouteName.character
                                        .replaceAll(':id', current.id),
                                    arguments: {
                                      'id': current.id,
                                      'name': current.name,
                                      'image': current.image,
                                    },
                                  );
                                },
                                leading: CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(
                                    current.image,
                                  ),
                                ),
                                title: Text(
                                  current.name,
                                  style: StylesTheme.bodyText.copyWith(
                                    color: ColorsTheme.fontThemeColor,
                                    fontWeight: FontWeight.w600,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                subtitle: Text(
                                  current.qty == 1
                                      ? Translator.get(
                                          '@value episode',
                                          params: {
                                            "value": current.qty.toString(),
                                          },
                                        )
                                      : Translator.get(
                                          '@value episodes',
                                          params: {
                                            "value": current.qty.toString(),
                                          },
                                        ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class InfosDesignCharacter extends StatelessWidget {
  final CharacterModel character;
  final List<CharacterAlongSide> actAlongSide;
  final bool isDevicePortrait;
  const InfosDesignCharacter({
    Key? key,
    required this.character,
    required this.actAlongSide,
    required this.isDevicePortrait,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isDevicePortrait ? null : 300,
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isDevicePortrait
            ? MainAxisAlignment.start
            : MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: isDevicePortrait ? 10 : 0,
          ),
          SimpleTextInfo(
            field: 'Name',
            value: character.name,
          ),
          Visibility(
            visible: character.status != "",
            child: SimpleTextInfo(
              field: 'Status',
              value: character.status,
            ),
          ),
          SimpleTextInfo(
            field: 'Species',
            value: character.species,
          ),
          SimpleTextInfo(
            field: 'Gender',
            value: character.gender,
          ),
          SimpleTextInfo(
            field: 'Location',
            value: character.location.name,
          ),
          SimpleTextInfo(
            field: 'Origin',
            value: character.origin.name,
          ),
          SimpleTextInfo(
              field: 'Appears in',
              value: character.episode.length == 1
                  ? Translator.get(
                      '@value episode',
                      params: {
                        "value": character.episode.length.toString(),
                      },
                    )
                  : Translator.get(
                      '@value episodes',
                      params: {
                        "value": character.episode.length.toString(),
                      },
                    )),
          SimpleTextInfo(
            field: 'Act along side',
            value: Translator.get(
              '@value characters',
              params: {
                "value": actAlongSide.length.toString(),
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SimpleTextInfo extends StatelessWidget {
  final String field;
  final String value;
  const SimpleTextInfo({Key? key, required this.field, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 2,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            Translator.get(field) + ': ',
            style: StylesTheme.bodyText.copyWith(
              color: Colors.black,
            ),
          ),
          Text(
            Translator.get(value),
            style: StylesTheme.bodyText.copyWith(
              color: ColorsTheme.fontThemeColor,
            ),
          )
        ],
      ),
    );
  }
}
