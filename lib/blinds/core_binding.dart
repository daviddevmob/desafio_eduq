import 'package:desafio_eduq/controllers/home_controller.dart';
import 'package:desafio_eduq/services/api/rick_and_morty/rick_morty_api_repository_interface.dart';
import 'package:get/get.dart';

import '../services/api/rick_and_morty/rick_morty_api_repository.dart';

class CoreBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<RickAndMortyApiRepository>(
      RickAndMortyApiRepository(),
      permanent: true,
    );
    Get.put<HomeController>(
      HomeController(),
      permanent: true,
    );
  }
}
