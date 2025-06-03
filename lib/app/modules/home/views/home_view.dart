import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart' as getx;
import 'package:responsive_framework/responsive_framework.dart';
import 'package:simplenotepad/app/routes/app_pages.dart';
import 'package:simplenotepad/app/utils/themes/border_themes.dart';
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
        columnPadding: EdgeInsets.only(left: 20, right: 20, top: 0).r,

        // row alignment setting
        rowCrossAxisAlignment: CrossAxisAlignment.start,
        rowMainAxisAlignment: MainAxisAlignment.start,
        rowMainAxisSize: MainAxisSize.max,
        rowVerticalDirection: VerticalDirection.down,
        rowPadding: EdgeInsets.only(left: 20, right: 20, top: 0).r,
        children: [
          ResponsiveRowColumnItem(
              child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: 1.sw),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Wrap(
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            direction: Axis.horizontal,
                            verticalDirection: VerticalDirection.down,
                            spacing: 10.w,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(5.r),
                                  child: getx.Obx(
                                    () {
                                      if (controller
                                          .isUserProfileLoading.value) {
                                        return CardLoading(
                                          height: 32.r,
                                          width: 32.r,
                                          borderRadius:
                                              BorderRadius.circular(5).r,
                                        );
                                      } else {
                                        return CachedNetworkImage(
                                          imageUrl:
                                              Uri.parse(controller.getPhotoUrl)
                                                  .toString(),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error_outline),
                                          placeholder: (context, url) =>
                                              CardLoading(
                                            height: 32.r,
                                            width: 32.r,
                                            borderRadius:
                                                BorderRadius.circular(5.r),
                                          ),
                                          width: 32.r,
                                          height: 32.r,
                                          fit: BoxFit.cover,
                                        );
                                      }
                                    },
                                  )),
                              getx.Obx(() {
                                if (controller.currentUserData.value == null) {
                                  return Center(
                                      child: CardLoading(height: 32.r));
                                } else {
                                  return ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxWidth: 100.w, minWidth: 30.w),
                                    child: Text(
                                      controller.getDisplayName,
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.secondaryColor),
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                      textAlign: TextAlign.start,
                                    ),
                                  );
                                }
                              })
                            ]),
                      ),
                      IconButton(
                        iconSize: 28.r,
                        onPressed: () => getx.Get.toNamed(Routes.PROFILE),
                        icon: Icon(
                          Icons.crop_square,
                          color: AppColor.primarySecondColor,
                        ),
                        splashColor: Colors.transparent,
                      )
                    ],
                  ))),
          ResponsiveRowColumnItem(
              child: Center(
            child: TextField(
              controller: controller.searchController,
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                  color: Colors.black),
              decoration: InputDecoration(
                  hintText: "Search Memo...",
                  prefixIcon: Icon(
                    Icons.search_outlined,
                    size: 24.r,
                  ),
                  suffixIcon:
                      getx.Obx(() => controller.getSearchText.value.isNotEmpty
                          ? IconButton(
                              padding: EdgeInsets.all(0).r,
                              onPressed: controller.clearSearch,
                              icon: Icon(
                                Icons.clear_outlined,
                                size: 24.r,
                              ))
                          : SizedBox.shrink()),
                  constraints: BoxConstraints(
                      maxHeight: 35.h, maxWidth: 0.9.sw, minHeight: 10.h),
                  contentPadding:
                      EdgeInsets.only(left: 10, top: 0, right: 10, bottom: 0).r,
                  fillColor: AppColor.primaryColor,
                  filled: true,
                  focusedBorder: AppBorder.focusedTextFieldBorder,
                  border: AppBorder.enabledTextFieldBorder),
            ),
          )),
          ResponsiveRowColumnItem(
              child: Expanded(
                  child: MasonryGridView.builder(
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      itemCount: 10,
                      gridDelegate:
                          SliverSimpleGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: ResponsiveValue(context,
                                      conditionalValues: [
                                        Condition.smallerThan(
                                            name: MOBILE,
                                            landscapeValue: 2,
                                            value: 1),
                                        Condition.equals(
                                            name: MOBILE,
                                            landscapeValue: 3,
                                            value: 2),
                                        Condition.largerThan(
                                            name: MOBILE,
                                            landscapeValue: 4,
                                            value: 3)
                                      ],
                                      defaultValue: 2)
                                  .value),
                      itemBuilder: (context, index) {
                        Random random = Random();
                        double randomNumber = random.nextInt(2) + 3;
                        final double itemHeight = 100 + (randomNumber % 5) * 40;
                        return Card(
                          color: Colors.lightBlue[100 * (index % 9)],
                          child: SizedBox(
                            height: itemHeight,
                            child: Center(
                              child: Text(
                                'Item $index\nH: $itemHeight',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                          ),
                        );
                      })))
        ],
      )),
    );
  }
}
