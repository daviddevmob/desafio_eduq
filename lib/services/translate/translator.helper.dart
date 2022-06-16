import 'package:desafio_eduq/services/translate/en_US.dart';
import 'package:desafio_eduq/services/translate/pt_BR.dart';

abstract class Translation {
  static Map<String, Map<String, String>> translations = {
    'en_US': en_US,
    'pt_BR': pt_BR,
  };
}
