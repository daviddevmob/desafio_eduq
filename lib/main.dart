import 'package:desafio_eduq/theme/colors_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'blinds/core_binding.dart';
import 'services/routes/app_routes_name.dart';
import 'services/routes/app_routes_pages.dart';
import 'services/translate/translator.helper.dart';

void main() async {
  runApp(const MyApp());
}

getExternalStorageDirectory() {}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Desafio EduQ',
      fallbackLocale: const Locale('en', 'US'),
      locale: Get.deviceLocale,
      debugShowCheckedModeBanner: false,
      translationsKeys: Translation.translations,
      initialRoute: RouteName.splash,
      initialBinding: CoreBinding(),
      getPages: RoutePage.pages,
    );
  }
}
