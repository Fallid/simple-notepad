import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AuthLoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RxBool showPassword = true.obs;
  RxBool isEmailValid = true.obs;
  RxBool isPasswordValid = true.obs;
  RxString errorEmailMesage = ''.obs;
  RxString errorPasswordMesage = ''.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  bool toggleObscureText(){
    showPassword.value = !showPassword.value;
    return showPassword.value;
  }

  RxBool emailValidation() {
    if (emailController.text.isEmpty || !emailController.text.isEmail) {
      errorEmailMesage.value = "Masukkan email yang valid";
      isEmailValid.value = false;
    } else {
      errorEmailMesage.value = "";
      isEmailValid.value = true;
    }
    return isEmailValid;
  }

  RxBool passwordValidation() {
    if (passwordController.text.isEmpty ||
        passwordController.value.text.length < 8) {
      errorPasswordMesage.value = "Password harus lebih dari 8 karakter";
      isPasswordValid.value = false;
    } else {
      errorPasswordMesage.value = "";
      isPasswordValid.value = true;
    }
    return isPasswordValid;
  }
}
