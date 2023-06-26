
import 'package:get/get.dart';

import 'langs/en_lang.dart';
import 'langs/id_lang.dart';

class AppTranslations extends Translations {

  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': en_lang,
    'id_ID': id_lang
  };
}
