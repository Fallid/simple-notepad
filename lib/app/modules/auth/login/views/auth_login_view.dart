import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart' as getx;
import 'package:responsive_framework/responsive_framework.dart';
import 'package:simplenotepad/app/routes/app_pages.dart';
import 'package:simplenotepad/app/utils/themes/color_themes.dart';
import 'package:simplenotepad/app/utils/themes/svg_themes.dart';
import 'package:simplenotepad/generated/locales.g.dart';

import '../../../widgets/languange_switch_button.dart';
import '../../widgets/authentication_button.dart';
import '../../widgets/register_login_text_button.dart';
import '../controllers/auth_login_controller.dart';
import 'widgets/login_text_field.dart';

class AuthLoginView extends getx.GetView<AuthLoginController> {
  const AuthLoginView({super.key});
  @override
  Widget build(BuildContext context) {
    debugPrint('Current layout: ${ResponsiveValue(context, conditionalValues: [
          Condition.largerThan(
              name: MOBILE,
              value: ResponsiveRowColumnType.COLUMN,
              landscapeValue: ResponsiveRowColumnType.COLUMN)
        ], defaultValue: ResponsiveRowColumnType.COLUMN).value}');
    return Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: SafeArea(
          top: true,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: context.height - ScreenUtil().statusBarHeight,
              minWidth: context.width,
            ),
            child: SingleChildScrollView(
              child: ResponsiveRowColumn(
                layout: ResponsiveValue(
                  context,
                  conditionalValues: [
                    Condition.largerThan(
                        name: MOBILE,
                        landscapeValue: ResponsiveRowColumnType.COLUMN,
                        value: ResponsiveRowColumnType.COLUMN)
                  ],
                  defaultValue: ResponsiveRowColumnType.COLUMN,
                ).value,

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

                // widget
                children: [
                  // header
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
                              LocaleKeys.header_auth_welcome_back.tr,
                              style: TextStyle(
                                  fontSize: 20.sp, color: Colors.white),
                            ),
                            LanguageSwitchButton(onPressed: () =>  controller.languangeController.toggleLocale(),)
                          ],
                        ),
                      ),
                      5.verticalSpace,
                      Text(
                        LocaleKeys.header_auth_greetings.tr,
                        style: TextStyle(fontSize: 11.sp, color: Colors.white),
                      ),
                      20.verticalSpace
                    ],
                  )),

                  // body email field
                  ResponsiveRowColumnItem(
                      child: LoginTextField(
                    controller: controller,
                    title: LocaleKeys.body_auth_email.tr,
                    isFieldValid: controller.isEmailValid,
                    loginHintText: LocaleKeys.body_auth_hint_email.tr,
                    validationType: 'email'.obs,
                  )),
                  ResponsiveRowColumnItem(
                      child: LoginTextField(
                          controller: controller,
                          title: LocaleKeys.body_auth_password.tr,
                          loginHintText: LocaleKeys.body_auth_hint_password.tr,
                          isFieldValid: controller.isPasswordValid,
                          contentPaddingTop:
                              MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                  ? 10
                                  : 5,
                          validationType: 'password'.obs)),
                  ResponsiveRowColumnItem(
                      child: SizedBox(
                          width: 1.sw,
                          child: GestureDetector(
                            onTap: () => debugPrint("Forgot Password clicked!"),
                            child: Text(
                              LocaleKeys.buttons_auth_forgot_password.tr,
                              style: TextStyle(
                                  color: AppColor.primarySecondColor,
                                  fontSize: 12.sp,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColor.primarySecondColor),
                              textAlign: TextAlign.end,
                            ),
                          ))),
                  ResponsiveRowColumnItem(
                      child: AuthenticationButton(
                          buttonValidation: controller.loginButtonValidation(),
                          isLoading: controller.isLoading,
                          onPressed: controller.loginUser,
                          title: LocaleKeys.buttons_auth_login.tr)),
                  ResponsiveRowColumnItem(
                    child: RegisterLoginTextButton(
                      message: LocaleKeys.body_auth_dont_have_account.tr,
                      textButton: LocaleKeys.buttons_auth_sign_up.tr,
                      onTap: () => getx.Get.toNamed(Routes.AUTH_REGISTER),
                    ),
                  ),
                  ResponsiveRowColumnItem(
                      child: Container(
                    alignment: Alignment.bottomRight,
                    child: 
                    SvgThemes().authCharacter(SvgRoutes.loginIllust)
                  ))
                ],
              ),
            ),
          ),
        ));
  }
}


