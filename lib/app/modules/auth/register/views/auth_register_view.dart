import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart' as getx;
import 'package:responsive_framework/responsive_framework.dart';
import 'package:simplenotepad/app/modules/auth/register/views/widgets/register_text_field.dart';
import 'package:simplenotepad/app/modules/auth/widgets/authentication_button.dart';
import 'package:simplenotepad/app/utils/themes/color_themes.dart';
import 'package:simplenotepad/app/utils/themes/svg_themes.dart';
import 'package:simplenotepad/generated/locales.g.dart';

import '../../../widgets/languange_switch_button.dart';
import '../../widgets/register_login_text_button.dart';
import '../controllers/auth_register_controller.dart';

class AuthRegisterView extends getx.GetView<AuthRegisterController> {
  const AuthRegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: SingleChildScrollView(
          child: SafeArea(
              child: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: context.height, minWidth: context.width),
            child: ResponsiveRowColumn(
              layout: ResponsiveValue(context,
                      conditionalValues: [
                        Condition.largerThan(
                            name: MOBILE,
                            landscapeValue: ResponsiveRowColumnType.COLUMN,
                            value: ResponsiveRowColumnType.COLUMN),
                      ],
                      defaultValue: ResponsiveRowColumnType.COLUMN)
                  .value,

              // column aligment setting
              columnCrossAxisAlignment: CrossAxisAlignment.start,
              columnMainAxisAlignment: MainAxisAlignment.start,
              columnMainAxisSize: MainAxisSize.max,
              columnVerticalDirection: VerticalDirection.down,
              columnSpacing: 20.r,
              columnPadding:
                  EdgeInsets.only(left: 20.r, right: 20.r, top: 20.r),

              // row alignment setting
              rowCrossAxisAlignment: CrossAxisAlignment.start,
              rowMainAxisAlignment: MainAxisAlignment.start,
              rowMainAxisSize: MainAxisSize.max,
              rowVerticalDirection: VerticalDirection.down,
              children: [
                ResponsiveRowColumnItem(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 1.sw,
                      height: 40.h,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            LocaleKeys.header_auth_create_account.tr,
                            style:
                                TextStyle(fontSize: 20.sp, color: Colors.white),
                          ),
                          LanguageSwitchButton(onPressed: () =>  controller.languangeController.toggleLocale(),)
                        ],
                      ),
                    ),
                    5.verticalSpace,
                    Text(
                      LocaleKeys.header_auth_information_field.tr,
                      style: TextStyle(fontSize: 11.sp, color: Colors.white),
                    ),
                    20.verticalSpace
                  ],
                )),
                ResponsiveRowColumnItem(
                    child: RegisterTextField(
                        controller: controller,
                        title: LocaleKeys.body_auth_name.tr,
                        registerHintText: LocaleKeys.body_auth_hint_name.tr,
                        isFieldValid: controller.isNameValid,
                        validationType: ValidationType.name)),
                ResponsiveRowColumnItem(
                    child: RegisterTextField(
                        controller: controller,
                        title: LocaleKeys.body_auth_email.tr,
                        registerHintText: LocaleKeys.body_auth_hint_email.tr,
                        isFieldValid: controller.isEmailValid,
                        validationType: ValidationType.email)),
                ResponsiveRowColumnItem(
                    child: RegisterTextField(
                        contentPaddingTop: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? 10
                            : 5,
                        controller: controller,
                        title: LocaleKeys.body_auth_password.tr,
                        registerHintText: LocaleKeys.body_auth_hint_password.tr,
                        isFieldValid: controller.isEmailValid,
                        validationType: ValidationType.password)),
                ResponsiveRowColumnItem(
                  child: RegisterLoginTextButton(
                    message: LocaleKeys.body_auth_already_have_account.tr,
                    textButton: LocaleKeys.buttons_auth_sign_in.tr,
                    onTap: () => getx.Get.back(),
                  ),
                ),
                ResponsiveRowColumnItem(
                    child: AuthenticationButton(
                        buttonValidation: controller.buttonValidation(),
                        isLoading: controller.isLoading,
                        onPressed: controller.registerUser,
                        title: LocaleKeys.buttons_auth_register.tr)),
                ResponsiveRowColumnItem(
                    child: Container(
                        alignment: Alignment.bottomRight,
                        child: SvgThemes()
                            .authCharacter(SvgRoutes.registerIllust)))
              ],
            ),
          )),
        ));
  }
}
