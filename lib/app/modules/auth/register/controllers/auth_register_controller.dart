import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simplenotepad/app/data/language.dart';
import 'package:simplenotepad/app/data/models/user_model.dart';
import 'package:simplenotepad/app/data/providers/authentication_provider.dart';
import 'package:simplenotepad/app/data/providers/user_provider.dart';
import 'package:simplenotepad/app/modules/auth/register/views/widgets/register_text_field.dart';
import 'package:simplenotepad/app/routes/app_pages.dart';
import 'package:simplenotepad/generated/locales.g.dart';

class AuthRegisterController extends GetxController {
  final LanguageController languangeController = Get.find<LanguageController>();
  final AuthenticationProvider _authProvider =
      Get.find<AuthenticationProvider>();
  final UserProvider _userProvider = Get.find<UserProvider>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final RegExp _regExp = RegExp(r"^[a-zA-Z ]*$");

  RxBool showPassword = true.obs;
  RxBool isNameValid = false.obs;
  RxBool isEmailValid = false.obs;
  RxBool isPasswordValid = false.obs;
  RxBool isLoading = false.obs;
  RxBool isButtonValid = false.obs;

  RxString errorNameMessage = ''.obs;
  RxString errorEmailMesage = ''.obs;
  RxString errorPasswordMesage = ''.obs;

  final count = 0.obs;
  @override
  void onInit() {
    nameController;
    emailController;
    passwordController;
    super.onInit();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void textValidationOnChanged(
      String value, bool isFieldValid, ValidationType validationType) {
    if (value.isEmpty) {
      isFieldValid = true;
    } else {
      switch (validationType) {
        case ValidationType.name:
          nameValidation();
          buttonValidation();
          debugPrint("name validation value:  ${nameValidation().value}");
          break;
        case ValidationType.email:
          emailValidation().value;
          buttonValidation();
          debugPrint("email validation value:  ${emailValidation().value}");
          break;
        case ValidationType.password:
          passwordValidation().value;
          buttonValidation();
          debugPrint(
              "password validation value:  ${passwordValidation().value}");
          break;
      }
    }
  }

  bool toggleObscureText() {
    showPassword.value = !showPassword.value;
    return showPassword.value;
  }

  bool obscureTextType(ValidationType validationType) {
    var obscureType = switch (validationType) {
      ValidationType.name => false,
      ValidationType.email => false,
      ValidationType.password => showPassword.isFalse ? false : true
    };
    return obscureType;
  }

  IconButton? suffixIconPassword(
    ValidationType validationType,
  ) {
    IconButton? suffixIcon = switch (validationType) {
      ValidationType.name => null,
      ValidationType.email => null,
      ValidationType.password => IconButton(
          onPressed: toggleObscureText,
          icon: Icon(
            showPassword.value ? Icons.visibility : Icons.visibility_off,
            color: Colors.black54,
            size: 26.r,
          ))
    };
    return suffixIcon;
  }

  String? errorTextField(ValidationType validationType, bool isFieldValid) {
    String errorText;
    if (isFieldValid) {
      return null;
    } else {
      errorText = switch (validationType) {
        ValidationType.name => errorNameMessage.value,
        ValidationType.email => errorEmailMesage.value,
        ValidationType.password => errorPasswordMesage.value,
      };
    }
    return errorText;
  }

  TextEditingController textControllerType(ValidationType validationType) {
    var controllerType = switch (validationType) {
      ValidationType.name => nameController,
      ValidationType.email => emailController,
      ValidationType.password => passwordController
    };
    return controllerType;
  }

  TextInputType textKeyboardType(ValidationType validationType) {
    var keyboardType = switch (validationType) {
      ValidationType.name => TextInputType.name,
      ValidationType.email => TextInputType.emailAddress,
      ValidationType.password => TextInputType.visiblePassword
    };
    return keyboardType;
  }

  RxBool nameValidation() {
    if (nameController.text.isEmpty || !nameController.text.contains(_regExp)) {
      errorNameMessage.value = LocaleKeys.error_auth_name_message.tr;
      isNameValid.value = false;
    } else {
      errorNameMessage.value = "";
      isEmailValid.value = true;
    }
    return isNameValid;
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
      errorPasswordMesage.value = LocaleKeys.error_auth_password_message.tr;
      isPasswordValid.value = false;
    } else {
      errorPasswordMesage.value = "";
      isPasswordValid.value = true;
    }
    return isPasswordValid;
  }

  RxBool buttonValidation() {
    isButtonValid.value = (nameController.text.isEmpty ||
                !nameController.text.contains(_regExp)) ||
            (emailController.text.isEmpty || !emailController.text.isEmail) ||
            (passwordController.text.length < 8 ||
                passwordController.text.isEmpty)
        ? false
        : true;
    return isButtonValid;
  }

  Future<void> registerUser() async {
    try {
      isLoading.value = true;
      UserCredential auth = await _authProvider.signUp(
          emailController.text, passwordController.text);
      User? user = auth.user;

      if (user != null) {
        sendEmailVerification();

        UserModel newUser = UserModel(
            uid: user.uid,
            name: nameController.text.trim(),
            email: user.email,
            photoUrl: "assets/images/blank_profile.png",
            createdAt: DateTime.now(),
            lastLogin: DateTime.now());

        await _userProvider.createUserFirestore(
            user.uid, newUser.toFirestore());

        await user.updateDisplayName(nameController.text.trim());

        Get.snackbar(LocaleKeys.success_auth_title_message.tr,
            LocaleKeys.success_auth_register_message.tr,
            duration: Duration(seconds: 3));
        Get.offAllNamed(Routes.AUTH_LOGIN);
      }
    } on FirebaseAuthException catch (e) {
      Get.showSnackbar(GetSnackBar(
        title: LocaleKeys.error_auth_title_message.tr,
        message: e.message,
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
      ));
    } catch (e) {
      Get.snackbar('Error', '${LocaleKeys.error_auth_register_message.tr} $e',
          backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        // Optionally display a message to the user
        debugPrint('Email verification sent!');
      } else {
        // User already verified or not signed in
        debugPrint('User already verified or not signed in.');
      }
    } catch (e) {
      // Handle any errors that may occur during the process
      debugPrint('Error sending verification email: $e');
    }
  }
}
