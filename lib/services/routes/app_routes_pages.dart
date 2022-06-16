import 'package:desafio_eduq/blinds/core_binding.dart';
import 'package:desafio_eduq/screens/home_screen.dart';
import 'package:desafio_eduq/screens/splash_screen.dart';
import 'package:desafio_eduq/services/routes/app_routes_name.dart';
import 'package:get/get.dart';

class RoutePage {
  static final List<GetPage> pages = [
    // Authentication
    GetPage(
      name: RouteName.splash,
      page: () => SplashScreen(),
      binding: CoreBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: RouteName.home,
      page: () => HomeScreen(),
      binding: CoreBinding(),
      transition: Transition.noTransition,
    ),
  ];
}
