import 'package:get/get.dart';
import 'package:simplenotepad/app/data/language.dart';

class PermanentBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<LanguageController>(LanguageController(), permanent: true);
  }
}
