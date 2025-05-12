import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simplenotepad/app/routes/app_pages.dart';

class AuthLoginController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
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
  void onReady() {
    super.onReady();
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
      await _firebaseAuth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      Get.snackbar("Success Login", "Login Sucees, Welcome back",
          duration: Duration(seconds: 3));
      Get.offAndToNamed(Routes.HOME);
    } on FirebaseAuthException catch (e) {
      Get.showSnackbar(GetSnackBar(
        title: "Failed Login",
        message: e.message,
        duration: Duration(seconds: 3),
      ));
    } catch (e) {
      Get.snackbar('Error', 'Login failed: $e', backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }
}
