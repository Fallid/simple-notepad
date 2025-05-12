import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simplenotepad/app/modules/auth/register/controllers/auth_register_controller.dart';

import '../../../../../utils/themes/border_themes.dart';
import '../../../../../utils/themes/color_themes.dart';

enum ValidationType { name, email, password }

class RegisterTextField extends StatelessWidget {
  const RegisterTextField(
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
      this.registerHintText,
      required this.title,
      required this.isFieldValid,
      required this.validationType});

  final AuthRegisterController controller;
  final ValidationType validationType;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final VerticalDirection verticalDirection;
  final double columnSpacing;

  final String title;
  final String? registerHintText;
  final RxBool isFieldValid;
  final double contentPaddingTop;
  final double contentPaddingBottom;
  final double contentPaddingLeft;
  final double contentPaddingRight;

  @override
  Widget build(BuildContext context) {
    debugPrint('Validation value: ${validationType}');
    debugPrint('isField value: ${isFieldValid.value}');
    isFieldValid.value = true;
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      verticalDirection: verticalDirection,
      spacing: columnSpacing,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 14.sp),
        ),
        10.verticalSpace,
        Obx(() => TextField(
              textAlign: TextAlign.left,
              onChanged: (value) {
                controller.textValidationOnChanged(
                    value, isFieldValid.value, validationType);
              },
              controller: controller.textControllerType(validationType),
              keyboardType: controller.textKeyboardType(validationType),
              obscureText: controller.obscureTextType(validationType),
              style: TextStyle(color: Colors.black, fontSize: 12.sp),
              decoration: InputDecoration(
                  constraints: BoxConstraints(maxWidth: context.width),
                  contentPadding: EdgeInsets.only(
                          left: contentPaddingLeft,
                          right: contentPaddingRight,
                          top: contentPaddingTop,
                          bottom: contentPaddingBottom)
                      .w,
                  filled: true,
                  fillColor: AppColor.primaryColor,
                  hintText: registerHintText,
                  hintStyle: TextStyle(color: Colors.black, fontSize: 12.sp),
                  errorText: controller.errorTextField(
                      validationType, isFieldValid.value),
                  suffixIcon: controller.suffixIconPassword(validationType),
                  errorBorder: AppBorder.errorTextFieldBorder,
                  focusedErrorBorder: AppBorder.errorTextFieldBorder,
                  focusedBorder: AppBorder.focusedTextFieldBorder,
                  enabledBorder: AppBorder.enabledTextFieldBorder),
            ))
      ],
    );
  }
}
