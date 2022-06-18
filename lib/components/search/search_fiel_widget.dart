import 'package:desafio_eduq/controllers/home_controller.dart';
import 'package:desafio_eduq/services/translate/translator_get.dart';
import 'package:desafio_eduq/theme/colors_theme.dart';
import 'package:desafio_eduq/theme/styles_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/result_search_characters_model.dart';
import '../../theme/responsive_theme.dart';

class SearchFieldWidget extends StatefulWidget {
  const SearchFieldWidget({Key? key}) : super(key: key);

  @override
  State<SearchFieldWidget> createState() => _SearchFieldWidgetState();
}

class _SearchFieldWidgetState extends State<SearchFieldWidget> {
  @override
  Widget build(BuildContext context) {
    bool isDevicePortrait =
        (Responsive.isMobile(context) && Responsive.isPortrait(context));
    final HomeController homeController = Get.find();
    return Align(
      alignment: Alignment.center,
      child: Obx(
        () => Container(
          width: isDevicePortrait
              ? null
              : Responsive.isMobile(context)
                  ? 400
                  : 600,
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 40,
                  child: TextField(
                    controller: homeController.nameController.value,
                    onChanged: (value) {
                      homeController.getC();
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorsTheme.fontThemeColor,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorsTheme.fontThemeColor,
                          width: 2,
                        ),
                      ),
                      hintText: Translator.get(
                        'Search for a character',
                      ),
                      hintStyle: StylesTheme.bodyText,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 2,
                ),
                margin: EdgeInsets.only(
                  left: 20,
                ),
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      Translator.get('Status') + ': ',
                      style: StylesTheme.bodyText.copyWith(
                        color: ColorsTheme.blue,
                      ),
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButton<Status>(
                        hint: Text(
                          "Status",
                          style: StylesTheme.bodyText.copyWith(
                            color: ColorsTheme.grey,
                          ),
                        ),
                        value: homeController.status.value,
                        items: [
                          DropdownMenuItem(
                            value: null,
                            child: Text(
                              Translator.get(
                                'None',
                              ),
                              style: StylesTheme.bodyText.copyWith(
                                color: ColorsTheme.blue,
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: Status.ALIVE,
                            child: Text(
                              Translator.get(
                                'Alive',
                              ),
                              style: StylesTheme.bodyText.copyWith(
                                color: ColorsTheme.blue,
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: Status.DEAD,
                            child: Text(
                              Translator.get(
                                'Dead',
                              ),
                              style: StylesTheme.bodyText.copyWith(
                                color: ColorsTheme.blue,
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: Status.UNKNOWN,
                            child: Text(
                              Translator.get(
                                'Unknown',
                              ),
                              style: StylesTheme.bodyText.copyWith(
                                color: ColorsTheme.blue,
                              ),
                            ),
                          ),
                        ],
                        dropdownColor: ColorsTheme.grey,
                        focusColor: ColorsTheme.grey,
                        iconEnabledColor: ColorsTheme.grey,
                        style: StylesTheme.bodyText.copyWith(
                          color: ColorsTheme.grey,
                        ),
                        onChanged: (value) {
                          homeController.status = value.obs;
                          setState(() {});
                          homeController.getC();
                        },
                      ),
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
