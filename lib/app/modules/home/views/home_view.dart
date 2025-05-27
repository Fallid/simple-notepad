import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart' as getx;
import 'package:responsive_framework/responsive_framework.dart';
import 'package:simplenotepad/app/utils/themes/color_themes.dart';

import '../controllers/home_controller.dart';

class HomeView extends getx.GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      floatingActionButton: IconButton.filled(
        onPressed: () {},
        icon: Icon(
          Icons.add,
          color: AppColor.backgroundColor,
          size: 32.r,
        ),
        style: ButtonStyle(
            minimumSize: WidgetStatePropertyAll(Size(10.r, 10.r)),
            maximumSize: WidgetStatePropertyAll(Size(80.r, 80.r)),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10).r)),
            backgroundColor:
                WidgetStatePropertyAll(AppColor.primarySecondColor)),
      ),
      body: SafeArea(
          child: ResponsiveRowColumn(
        layout: ResponsiveValue(context,
                conditionalValues: [
                  Condition.largerThan(
                      name: MOBILE,
                      landscapeValue: ResponsiveRowColumnType.COLUMN,
                      value: ResponsiveRowColumnType.COLUMN)
                ],
                defaultValue: ResponsiveRowColumnType.COLUMN)
            .value,

        // column alignment setting
        columnCrossAxisAlignment: CrossAxisAlignment.start,
        columnMainAxisAlignment: MainAxisAlignment.start,
        columnMainAxisSize: MainAxisSize.max,
        columnVerticalDirection: VerticalDirection.down,
        columnSpacing: 20.r,
        columnPadding: EdgeInsets.only(left: 20.r, right: 20.r, top: 20.r),

        // row alignment setting
        rowCrossAxisAlignment: CrossAxisAlignment.start,
        rowMainAxisAlignment: MainAxisAlignment.start,
        rowMainAxisSize: MainAxisSize.max,
        rowVerticalDirection: VerticalDirection.down,
        rowPadding: EdgeInsets.only(left: 20.r, right: 20.r, top: 20.r),
        children: [
          ResponsiveRowColumnItem(
              child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: context.width),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Wrap(
                          alignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 10.w,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5.r),
                              child: CachedNetworkImage(
                                imageUrl: "assets/images/blank_profile.png",
                                placeholder: (context, url) => CardLoading(
                                  height: 32.r,
                                  width: 32.r,
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                width: 32.r,
                                height: 32.r,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Text(
                              "Halo",
                              style: TextStyle(color: AppColor.secondaryColor),
                            )
                          ]),
                      Text(
                        "Halo",
                        style: TextStyle(color: AppColor.secondaryColor),
                      )
                    ],
                  )))
        ],
      )),
    );
  }
}
