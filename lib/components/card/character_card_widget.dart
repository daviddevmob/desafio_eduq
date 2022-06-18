import 'package:cached_network_image/cached_network_image.dart';
import 'package:desafio_eduq/components/others/gesture_scale_tap_widget.dart';
import 'package:desafio_eduq/services/routes/app_routes_name.dart';
import 'package:desafio_eduq/theme/colors_theme.dart';
import 'package:desafio_eduq/theme/styles_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/result_search_characters_model.dart';

class CharacterCardWidget extends StatelessWidget {
  final Character character;
  const CharacterCardWidget({
    Key? key,
    required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureScaleTap(
      onTap: () async {
        Get.toNamed(
          RouteName.character.replaceAll(':id', character.id),
          arguments: {
            'id': character.id,
            'name': character.name,
            'image': character.image,
          },
        );
      },
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
            image: CachedNetworkImageProvider(
              character.image,
            ),
          ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 40,
            width: 200,
            padding: EdgeInsets.symmetric(
              horizontal: 5,
            ),
            decoration: BoxDecoration(
              color: ColorsTheme.fontThemeColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
            ),
            child: Center(
              child: Text(
                character.name,
                textAlign: TextAlign.center,
                style: StylesTheme.bodyText.copyWith(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
