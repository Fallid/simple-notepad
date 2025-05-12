import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/themes/color_themes.dart';

class RegisterLoginTextButton extends StatelessWidget {
  const RegisterLoginTextButton(
      {super.key,
      required this.message,
      required this.textButton,
      required this.onTap});

  final String message;
  final String textButton;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      child: Text.rich(
          textAlign: TextAlign.center,
          TextSpan(children: [
            TextSpan(
                text: message,
                style:
                    TextStyle(color: AppColor.secondaryColor, fontSize: 12.sp)),
            TextSpan(
                text: textButton,
                style: TextStyle(
                    color: AppColor.primarySecondColor,
                    fontSize: 12.sp,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColor.primarySecondColor),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    if (onTap != null) {
                      onTap!();
                    }
                  })
          ])),
    );
  }
}
