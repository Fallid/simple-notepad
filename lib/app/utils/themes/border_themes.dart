import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBorder {
  static UnderlineInputBorder errorTextFieldBorder = UnderlineInputBorder(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(10.r), topLeft: Radius.circular(10).w));

  static OutlineInputBorder focusedTextFieldBorder =
      OutlineInputBorder(borderRadius: BorderRadius.circular(10).w);
  
  static OutlineInputBorder enabledTextFieldBorder =
      OutlineInputBorder(borderRadius: BorderRadius.circular(10).w);
}
