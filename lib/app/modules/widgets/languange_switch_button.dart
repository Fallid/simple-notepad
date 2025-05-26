import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simplenotepad/app/utils/themes/svg_themes.dart';

class LanguageSwitchButton extends StatelessWidget {
  const LanguageSwitchButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SvgPicture.asset(
        SvgRoutes.translateIllust,
        fit: BoxFit.contain,
        colorFilter: ColorFilter.mode(
            Colors.white, BlendMode.srcIn),
        height: 24.r,
        width: 24.r,
      ),
    );
  }
}