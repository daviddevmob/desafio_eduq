import 'package:cached_network_image/cached_network_image.dart';
import 'package:desafio_eduq/theme/colors_theme.dart';
import 'package:desafio_eduq/theme/styles_theme.dart';
import 'package:flutter/material.dart';

import '../../models/result_search_characters_model.dart';

class CharacterCardWidget extends StatelessWidget {
  final Character character;
  const CharacterCardWidget({
    Key? key,
    required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
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
            color: ColorsTheme.yellow.withOpacity(0.9),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Center(
            child: Text(
              character.name,
              textAlign: TextAlign.center,
              style: StylesTheme.bodyText.copyWith(
                color: ColorsTheme.blue,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
