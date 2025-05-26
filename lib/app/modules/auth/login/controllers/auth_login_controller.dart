import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simplenotepad/app/data/language.dart';
import 'package:simplenotepad/app/data/providers/authentication_provider.dart';
import 'package:simplenotepad/app/routes/app_pages.dart';
import 'package:simplenotepad/generated/locales.g.dart';

class AuthLoginController extends GetxController {
  final LanguageController languangeController = Get.find<LanguageController>();
  final AuthenticationProvider _authenticationProvider =
      Get.find<AuthenticationProvider>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool showPassword = true.obs;
  RxBool isEmailValid = false.obs;
  RxBool isPasswordValid = false.obs;
  RxBool isLoading = false.obs;
  RxBool isButtonValid = false.obs;
  RxString errorEmailMesage = ''.obs;
  RxString errorPasswordMesage = ''.obs;

  @override
  void onInit() {
    emailController;
    passwordController;
    super.onInit();
  }


  @override
  void onClose() {
    emailController.clear();
    passwordController.clear();
    super.onClose();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool toggleObscureText() {
    showPassword.value = !showPassword.value;
    return showPassword.value;
  }

  RxBool emailValidation() {
    if (emailController.text.isEmpty || !emailController.text.isEmail) {
      errorEmailMesage.value = LocaleKeys.error_auth_email_message.tr;
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
      errorPasswordMesage.value =
          LocaleKeys.error_auth_password_message.tr;
      isPasswordValid.value = false;
    } else {
      errorPasswordMesage.value = "";
      isPasswordValid.value = true;
    }
    return isPasswordValid;
  }

  RxBool loginButtonValidation() {
    isButtonValid.value =
        (emailController.text.isEmpty || !emailController.text.isEmail) ||
                (passwordController.text.length < 8 ||
                    passwordController.text.isEmpty)
            ? false
            : true;

    return isButtonValid;
  }

  Future<void> loginUser() async {
    try {
      isLoading.value = true;
      await _authenticationProvider.signIn(
          emailController.text.trim(), passwordController.text.trim());
      Get.snackbar(LocaleKeys.success_auth_title_message.tr,
          LocaleKeys.success_auth_login_message.tr,
          duration: Duration(seconds: 3));
      Get.offAndToNamed(Routes.HOME);
    } on FirebaseAuthException catch (e) {
      Get.showSnackbar(GetSnackBar(
        title: LocaleKeys.error_auth_title_message.tr,
        message: e.message,
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
      ));
    } catch (e) {
      Get.snackbar(
          'Error', '${LocaleKeys.error_auth_login_message.tr} $e',
          backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }
}
