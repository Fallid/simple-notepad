import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simplenotepad/app/utils/dimension/screen_dimension.dart';
import 'package:simplenotepad/app/utils/themes/border_themes.dart';
import 'package:simplenotepad/app/utils/themes/color_themes.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton(
      {super.key,
      required this.label,
      this.labelSize = 12,
      this.labelColor = AppColor.primarySecondColor,
      this.icons,
      this.iconSize = 24,
      this.iconColor = AppColor.primarySecondColor,
      required this.onPressed});

  final String label;
  final IconData? icons;
  final double iconSize;
  final Color iconColor;
  final double labelSize;
  final Color labelColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 10.0).r),
        backgroundColor: WidgetStatePropertyAll(AppColor.backgroundColor),
        minimumSize: WidgetStatePropertyAll(Size(1.sw, 31.h)),
        shape: WidgetStatePropertyAll(AppBorder.buttonBorder),
      ),
      onPressed: onPressed,
      icon: icons.isBlank == true
          ? null
          : Icon(
              icons,
              size: ScreenDimension.isMobile(context)
                  ? iconSize.r
                  : ScreenDimension.isTablet(context)
                      ? 32.r
                      : 38.r,
              color: iconColor,
            ),
      label: Text(
        label,
        style: TextStyle(fontSize: labelSize.sp, color: labelColor),
      ),
    );
  }
}
