import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simplenotepad/app/utils/dimension/screen_dimension.dart';
import 'package:simplenotepad/app/utils/themes/border_themes.dart';
import 'package:simplenotepad/app/utils/themes/color_themes.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.controller,
      this.title = "",
      this.initialValue = '',
      this.mainAxisAlignment = MainAxisAlignment.center,
      this.crossAxisAlignment = CrossAxisAlignment.start,
      this.verticalDirection = VerticalDirection.down,
      this.color = AppColor.primaryColor});

  final TextEditingController controller;
  final Color color;
  final String title;
  final String initialValue;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final VerticalDirection verticalDirection;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: ScreenDimension.isMobile(context)
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      verticalDirection: VerticalDirection.down,
      children: [
        title.isNotEmpty
            ? Text(
                title,
                textAlign: TextAlign.start,
                style:
                    TextStyle(fontSize: 12.sp, color: AppColor.secondaryColor),
              )
            : SizedBox.shrink(),
        TextField(
          controller: controller..text = initialValue,
          style: TextStyle(
              fontSize: ScreenDimension.isMobile(context)
                  ? 12.sp
                  : ScreenDimension.isTablet(context)
                      ? 9.sp
                      : 8.sp),
          decoration: InputDecoration(
              filled: true,
              fillColor: color,
              constraints: ScreenDimension.isMobile(context)
                  ? BoxConstraints(
                      maxHeight: 31.w,
                    )
                  : ScreenDimension.isDesktop(context)
                      ? BoxConstraints(
                          maxHeight: 50.w,
                        )
                      : null,
              contentPadding:
                  EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0).r,
              border: AppBorder.enabledTextFieldBorder,
              errorBorder: AppBorder.errorTextFieldBorder,
              focusedBorder: AppBorder.focusedTextFieldBorder),
        ),
      ],
    );
  }
}
