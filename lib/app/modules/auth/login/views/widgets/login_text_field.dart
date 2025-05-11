import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../utils/themes/border_themes.dart';
import '../../../../../utils/themes/color_themes.dart';
import '../../controllers/auth_login_controller.dart';

class LoginTextField extends StatelessWidget {
  const LoginTextField(
      {super.key,
      required this.controller,
      this.crossAxisAlignment = CrossAxisAlignment.start,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.verticalDirection = VerticalDirection.down,
      this.columnSpacing = 0.0,
      this.contentPaddingTop = 0.0,
      this.contentPaddingBottom = 0.0,
      this.contentPaddingLeft = 0.0,
      this.contentPaddingRight = 0.0,
      this.loginHintText,
      required this.title,
      required this.isFieldValid,
      required this.validationType});

  final AuthLoginController controller;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final VerticalDirection verticalDirection;
  final double columnSpacing;

  final String title;
  final String? loginHintText;
  final RxBool isFieldValid;
  final RxString validationType;
  final double contentPaddingTop;
  final double contentPaddingBottom;
  final double contentPaddingLeft;
  final double contentPaddingRight;

  @override
  Widget build(BuildContext context) {
    debugPrint('Validation value: ${validationType}');
    debugPrint('isField value: ${isFieldValid.value}');
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      verticalDirection: verticalDirection,
      spacing: columnSpacing,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        10.verticalSpace,
        Obx(() => TextField(
          onChanged: (value) {
            if (value.isEmpty ||
                controller.emailController.value.toString().isEmpty) {
              isFieldValid.value = true;
            } else {
              switch (validationType.value) {
                case "email":
                  controller.emailValidation().value;
                  debugPrint(
                      "email validation value:  ${controller.emailValidation().value}");
                  break;
                case "password":
                  controller.passwordValidation().value;
                  debugPrint(
                      "password validation value:  ${controller.passwordValidation().value}");
                  break;
                default:
                  controller.isEmailValid = true.obs;
                  // controller.isEmailValid = true.obs;
                  break;
              }
            }
          },
          controller: validationType.value.contains("email")
              ? controller.emailController
              : controller.passwordController,
          keyboardType: validationType.value.contains("email")
              ? TextInputType.emailAddress
              : TextInputType.visiblePassword,
          obscureText: validationType.value.contains("email")
              ? false
              : controller.showPassword.value,
          style: TextStyle(color: Colors.black, fontSize: 12.sp),
          decoration: InputDecoration(
              constraints: BoxConstraints(
                  maxWidth: context.width),
              contentPadding: EdgeInsets.only(
                      left: contentPaddingLeft,
                      right: contentPaddingRight,
                      top: contentPaddingTop,
                      bottom: contentPaddingBottom)
                  .w,
              filled: true,
              fillColor: AppColor.primaryColor,
              hintText: loginHintText,
              hintStyle: TextStyle(color: Colors.black, fontSize: 12.sp),
              errorText: isFieldValid.isFalse
                  ? validationType.value.contains("email")
                      ? controller.errorEmailMesage.value
                      : controller.errorPasswordMesage.value
                  : null,
              suffixIcon: validationType.value.contains("email")
                  ? null
                  : IconButton(
                      onPressed: controller.toggleObscureText,
                      icon: Icon(
                        controller.showPassword.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black54,
                        size: 26.r,
                      )),
              errorBorder: AppBorder.errorTextFieldBorder,
              focusedErrorBorder: AppBorder.errorTextFieldBorder,
              focusedBorder: AppBorder.focusedTextFieldBorder,
              enabledBorder: AppBorder.enabledTextFieldBorder),
        ))
      ],
    );
  }
}
