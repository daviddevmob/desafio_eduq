import 'package:desafio_eduq/models/character_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../models/result_search_characters_model.dart';
import '../services/api/rick_and_morty/rick_morty_api_repository.dart';

class HomeController extends GetxController {
  final RickAndMortyApiRepository rickAndMortyApiRepository = Get.find();
  Rx<ResultSearchCharacters> searchCharacters = ResultSearchCharacters(
    info: Info(count: 0),
    results: [],
  ).obs;
  RxInt page = 1.obs;
  Rx<TextEditingController> nameController = TextEditingController().obs;
  RxBool initLoadFinish = false.obs;
  RxBool loadScreen = false.obs;
  Rx<Status?> status = null.obs;
  HomeController() {
    getC();
  }

  getC() async {
    loadScreen.value = true;
    ResultSearchCharacters? result =
        await rickAndMortyApiRepository.getCharacters(
      page: page.value,
      name: nameController.value.text,
      status: status.value == null
          ? null
          : (status.value!.name.toString().toLowerCase()),
    );
    loadScreen.value = false;
    if (result != null) {
      initLoadFinish.value = true;
      searchCharacters.value = result;
    }
  }

  getSingleCharacter({required String id}) async {
    CharacterModel newCharacter =
        await rickAndMortyApiRepository.getSingleCharacter(
      id: id,
    );
    return newCharacter;
  }
}
