import 'package:get/get.dart';
import 'package:simplenotepad/app/routes/app_pages.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    loadingHomeScreen();
    super.onReady();
  }

  @override
  void onClose() {
    Duration();
    super.onClose();
  }

  void loadingHomeScreen() async {
    await Future.delayed(const Duration(milliseconds: 4500), () {
      Get.offAndToNamed(Routes.AUTH_LOGIN);
    });
  }
}
