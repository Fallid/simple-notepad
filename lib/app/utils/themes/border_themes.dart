import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simplenotepad/app/utils/themes/color_themes.dart';

class AppBorder {
  static UnderlineInputBorder errorTextFieldBorder = UnderlineInputBorder(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(7).r, topLeft: Radius.circular(7).r));

  static OutlineInputBorder focusedTextFieldBorder =
      OutlineInputBorder(borderRadius: BorderRadius.circular(7).r);

  static OutlineInputBorder enabledTextFieldBorder =
      OutlineInputBorder(borderRadius: BorderRadius.circular(7).r);

  static RoundedRectangleBorder buttonBorder =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10).r, side: BorderSide(color: AppColor.primarySecondColor));
}
