import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart' as getx;
import 'package:responsive_framework/responsive_framework.dart';
import 'package:simplenotepad/app/routes/app_pages.dart';
import 'package:simplenotepad/app/utils/themes/color_themes.dart';

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
                minWidth: context.width,),
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
                      Text(
                        'Hey, welcome back 👋',
                        style: TextStyle(fontSize: 20.sp, color: Colors.white),
                      ),
                      10.verticalSpace,
                      Text(
                        "Enter the information you entered while registering",
                        style: TextStyle(fontSize: 11.sp, color: Colors.white),
                      ),
                      20.verticalSpace
                    ],
                  )),
                      
                  // body email field
                  ResponsiveRowColumnItem(
                      child: LoginTextField(
                    controller: controller,
                    title: "Email",
                    isFieldValid: controller.isEmailValid,
                    loginHintText: "example@mail.com",
                    contentPaddingLeft: 10,
                    contentPaddingRight: 10,
                    validationType: 'email'.obs,
                  )),
                  ResponsiveRowColumnItem(
                      child: LoginTextField(
                          controller: controller,
                          title: "Password",
                          loginHintText: "*****",
                          isFieldValid: controller.isPasswordValid,
                          contentPaddingTop:
                              MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                  ? 10
                                  : 5,
                          contentPaddingLeft: 10,
                          contentPaddingRight: 10,
                          validationType: 'password'.obs)),
                  ResponsiveRowColumnItem(
                      child: SizedBox(
                          width: 1.sw,
                          child: GestureDetector(
                            onTap: () => debugPrint("Forgot Password clicked!"),
                            child: Text(
                              "Forgot Password",
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
                          title: "Login")),
                  ResponsiveRowColumnItem(
                    child: RegisterLoginTextButton(
                      message: "Don't have an account? ",
                      textButton: "Sign up for free",
                      onTap: () => getx.Get.toNamed(Routes.AUTH_REGISTER),
                    ),
                  ),
                  ResponsiveRowColumnItem(
                      child: Container(
                    alignment: Alignment.bottomRight,
                    child: SvgPicture.asset(
                      'assets/svg/login_illust.svg',
                      fit: BoxFit.cover,
                      height: 200.r,
                      width: 200.r,
                    ),
                  ))
                ],
              ),
            ),
          ),
        ));
  }
}
