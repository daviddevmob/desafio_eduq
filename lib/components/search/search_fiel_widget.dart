import 'package:desafio_eduq/controllers/home_controller.dart';
import 'package:desafio_eduq/services/translate/translator_get.dart';
import 'package:desafio_eduq/theme/colors_theme.dart';
import 'package:desafio_eduq/theme/styles_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/result_search_characters_model.dart';

class SearchFieldWidget extends StatelessWidget {
  const SearchFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();
    return Obx(
      () => Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextField(
                controller: homeController.nameController.value,
                onChanged: (value) {
                  homeController.getC();
                },
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
                color: ColorsTheme.blue,
                borderRadius: BorderRadius.circular(5),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<Status>(
                  hint: Text(
                    "Status",
                    style: StylesTheme.bodyText.copyWith(
                      color: ColorsTheme.blue,
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
                          color: ColorsTheme.grey,
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
                          color: ColorsTheme.grey,
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
                          color: ColorsTheme.grey,
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
                          color: ColorsTheme.grey,
                        ),
                      ),
                    ),
                  ],
                  dropdownColor: ColorsTheme.blue,
                  focusColor: ColorsTheme.blue,
                  iconEnabledColor: ColorsTheme.grey,
                  style: StylesTheme.bodyText.copyWith(
                    color: ColorsTheme.grey,
                  ),
                  onChanged: (value) {
                    homeController.status = value.obs;
                    homeController.getC();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
