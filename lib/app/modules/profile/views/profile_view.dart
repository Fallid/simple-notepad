import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart' as getx;
import 'package:responsive_framework/responsive_framework.dart';
import 'package:simplenotepad/app/modules/auth/widgets/primarry_button.dart';
import 'package:simplenotepad/app/modules/components/languange_switch_button.dart';
import 'package:simplenotepad/app/utils/dimension/screen_dimension.dart';
import 'package:simplenotepad/app/utils/themes/color_themes.dart';
import 'package:simplenotepad/generated/locales.g.dart';

import '../../components/custom_text_field.dart';
import '../../components/secondary_button.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends getx.GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.backgroundColor,
        appBar: AppBar(
          toolbarHeight: 40.h,
          backgroundColor: AppColor.backgroundColor,
          leading: IconButton(
              color: AppColor.primarySecondColor,
              iconSize: 24.r,
              onPressed: () => getx.Get.back(),
              icon: Icon(Icons.arrow_back_ios_new_rounded)),
          actionsPadding: EdgeInsets.only(right: 20).r,
          actions: [
            LanguageSwitchButton(
                onPressed: controller.languageController.toggleLocale)
          ],
        ),
        body: SafeArea(
            child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 1.sh,
            minWidth: 1.sw,
          ),
          child: SingleChildScrollView(
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
              columnSpacing: 15.r,
              columnPadding: EdgeInsets.only(left: 20, right: 20, top: 20).r,

              // row alignment setting
              rowCrossAxisAlignment: CrossAxisAlignment.start,
              rowMainAxisAlignment: MainAxisAlignment.start,
              rowMainAxisSize: MainAxisSize.max,
              rowVerticalDirection: VerticalDirection.down,
              rowPadding: EdgeInsets.only(left: 20, right: 20, top: 0).r,

              children: [
                ResponsiveRowColumnItem(
                    child: Center(
                        child: Stack(
                  children: [
                    getx.Obx(() => ClipRRect(
                          borderRadius: BorderRadius.circular(5.r),
                          child: controller.selectedImageFile != null
                              ? Image.file(
                                  controller.selectedImageFile!,
                                  width: 80.w,
                                  height: 80.w,
                                  fit: BoxFit.cover,
                                )
                              : CachedNetworkImage(
                                  imageUrl:
                                      Uri.parse(controller.getPhoto).toString(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error_outline),
                                  placeholder: (context, url) => CardLoading(
                                    height: 80.w,
                                    width: 80.w,
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  width: 80.w,
                                  height: 80.w,
                                  fit: BoxFit.cover,
                                ),
                        )),
                    Positioned(
                      width: 80.w,
                      height: 80.w,
                      top: 30.w,
                      left: 30.w,
                      child: IconButton(
                          iconSize: ScreenDimension.isMobile(context)
                              ? 22.r
                              : ScreenDimension.isTablet(context)
                                  ? 28.r
                                  : 34.r,
                          onPressed: controller.pickAndDisplayLocalImage,
                          icon: Icon(Icons.edit)),
                    )
                  ],
                ))),
                ResponsiveRowColumnItem(
                    child: GridView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: ResponsiveValue(context,
                            conditionalValues: [
                              Condition.largerThan(
                                  name: MOBILE, value: 2, landscapeValue: 2)
                            ],
                            defaultValue: 1)
                        .value,
                    mainAxisExtent: controller.mainAxisExtent(
                        context), // Setiap item akan memiliki tinggi 150 piksel
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  children: [
                    CustomTextField(
                      controller: controller.nameController,
                      title: LocaleKeys.body_auth_name.tr,
                      initialValue: controller.getDisplayName,
                    ),
                    CustomTextField(
                      controller: controller.emailController,
                      title: LocaleKeys.body_auth_email.tr,
                      initialValue: controller.getEmail,
                    ),
                    CustomTextField(
                      controller: controller.passwordController,
                      title: LocaleKeys.body_auth_new_password.tr,
                    ),
                    CustomTextField(
                      controller: controller.confirmPassowrdController,
                      title: LocaleKeys.body_auth_confirm_password.tr,
                    ),
                  ],
                )),
                ResponsiveRowColumnItem(
                    child: MaxWidthBox(
                        maxWidth: ResponsiveBreakpoints.of(context).isMobile
                            ? 1.sw
                            : 1.sw - 0.5.sw,
                        child: PrimaryButton(
                            buttonValidation: true.obs,
                            isLoading: false.obs,
                            onPressed: controller.uploadAndUpdateProfilePicture,
                            title: LocaleKeys.buttons_auth_update.tr))),
                ResponsiveRowColumnItem(
                    child: MaxWidthBox(
                        maxWidth: ScreenDimension.isMobile(context)
                            ? 1.sw
                            : 1.sw - 0.5.sw,
                        child: SecondaryButton(
                          label: LocaleKeys.buttons_auth_logout.tr,
                          icons: Icons.logout,
                          onPressed: () => controller.logout,
                        )))
              ],
            ),
          ),
        )));
  }
}
