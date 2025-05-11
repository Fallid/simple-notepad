import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'package:get/get.dart' as getx;
import 'package:responsive_framework/responsive_framework.dart';
import 'package:simplenotepad/app/utils/themes/color_themes.dart';

import '../controllers/splash_controller.dart';

class SplashView extends getx.GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    print('context height: ${context.height}');
    print('Current layout: ${ResponsiveValue(context, conditionalValues: [
          Condition.largerThan(
              name: MOBILE,
              value: ResponsiveRowColumnType.COLUMN,
              landscapeValue: ResponsiveRowColumnType.COLUMN)
        ], defaultValue: ResponsiveRowColumnType.COLUMN).value}');
    controller.loadingHomeScreen();
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: context.height, minWidth: context.width),
          child: ResponsiveRowColumn(
            layout: ResponsiveValue(context,
                    conditionalValues: [
                      Condition.largerThan(
                          name: MOBILE,
                          value: ResponsiveRowColumnType.COLUMN,
                          landscapeValue: ResponsiveRowColumnType.COLUMN)
                    ],
                    defaultValue: ResponsiveRowColumnType.COLUMN)
                .value,

            // column aligment setting
            columnCrossAxisAlignment: CrossAxisAlignment.center,
            columnMainAxisAlignment: MainAxisAlignment.center,
            columnMainAxisSize: MainAxisSize.max,
            // columnPadding: EdgeInsets.all(8.r),
            columnSpacing: 10.h,
            columnVerticalDirection: VerticalDirection.down,

            // row alignment setting
            rowCrossAxisAlignment: CrossAxisAlignment.center,
            rowMainAxisAlignment: MainAxisAlignment.center,
            rowMainAxisSize: MainAxisSize.max,
            // rowPadding: EdgeInsets.all(8.r),
            // rowSpacing: 0,
            rowVerticalDirection: VerticalDirection.down,

            children: [
              ResponsiveRowColumnItem(
                // column item aligment setting
                columnFlex: 0,
                columnFit: FlexFit.loose,
                columnOrder: 0,

                // row item aligment setting
                rowFlex: 0,
                rowFit: FlexFit.loose,
                rowOrder: 0,

                child: SvgPicture.asset(
                  'assets/svg/splash_illust.svg',
                  fit: BoxFit.cover,
                  height: 300.r,
                  width: 300.r,
                ),
              ),
              ResponsiveRowColumnItem(
                  // column item aligment setting
                  columnFlex: 0,
                  columnFit: FlexFit.loose,
                  columnOrder: 1,

                  // row item aligment setting
                  rowFlex: 0,
                  rowFit: FlexFit.loose,
                  rowOrder: 1,
                  child: SizedBox(
                    width: 0.9.sw,
                    child: LinearPercentIndicator(
                      lineHeight: 10.h,
                      barRadius: Radius.circular(18.r),
                      animation: true,
                      animationDuration: 3500,
                      percent: 100 / 100,
                      backgroundColor: AppColor.primaryColor,
                      progressColor: AppColor.secondaryColor,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
