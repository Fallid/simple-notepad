import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simplenotepad/app/utils/themes/color_themes.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.buttonValidation,
    required this.isLoading,
    required this.onPressed,
    required this.title,
  });

  final RxBool buttonValidation;
  final RxBool isLoading;
  final VoidCallback? onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ElevatedButton(
          style: ButtonStyle(
              padding:
                  WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 10.0).r),
              backgroundColor: WidgetStatePropertyAll(buttonValidation.isFalse
                  ? AppColor.primarySecondDisableColor
                  : AppColor.primarySecondColor),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10).r)),
              minimumSize: WidgetStatePropertyAll(Size(1.sw, 31.h))),
          onPressed:
              (buttonValidation.isTrue && isLoading.isFalse) ? onPressed : null,
          child: isLoading.isTrue
              ? CircularProgressIndicator()
              : Text(
                  title,
                  style: TextStyle(
                      color: AppColor.backgroundColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold),
                )),
    );
  }
}
