import 'package:get/get.dart';

class Translator {
  static String get(String key, {Map<String, String>? params}) {
    if (params != null) {
      return key.trParams(params);
    }
    return key.tr;
  }
}
