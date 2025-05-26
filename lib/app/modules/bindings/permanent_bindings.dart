import 'package:get/get.dart';
import 'package:simplenotepad/app/data/language.dart';
import 'package:simplenotepad/app/data/providers/authentication_provider.dart';
import 'package:simplenotepad/app/data/providers/user_provider.dart';

class PermanentBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<LanguageController>(LanguageController(), permanent: true);

    Get.lazyPut<AuthenticationProvider>(() => AuthenticationProvider(),
        fenix: true);
    Get.lazyPut<UserProvider>(() => UserProvider(), fenix: true);
  }
}
