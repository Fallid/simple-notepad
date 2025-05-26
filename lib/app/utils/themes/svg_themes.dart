import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgRoutes {
  static const String loginIllust = "assets/svg/login_illust.svg";
  static const String registerIllust = "assets/svg/register_illust.svg";
  static const String splashIllust = "assets/svg/splash_illust.svg";
  static const String translateIllust = "assets/svg/translate_illust.svg";
}

class SvgThemes {
  SvgPicture authCharacter(String assetName) {
    return SvgPicture.asset(
      assetName,
      fit: BoxFit.cover,
      height: 200.r,
      width: 200.r,
    );
  }
}
