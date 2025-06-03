import 'package:get/get.dart';
import 'package:simplenotepad/app/data/language.dart';
import 'package:simplenotepad/app/data/providers/authentication_provider.dart';
import 'package:simplenotepad/app/data/providers/user_provider.dart';
import 'package:simplenotepad/app/modules/home/controllers/home_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<LanguageController>(LanguageController(), permanent: true);
    Get.put<AuthenticationProvider>(AuthenticationProvider(), permanent: true);
    Get.put<UserProvider>(UserProvider(), permanent: true);
    Get.put<HomeController>(HomeController(), permanent: true);
  }
}
