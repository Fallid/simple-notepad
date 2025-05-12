import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart' as getx;
import 'package:responsive_framework/responsive_framework.dart';
import 'package:simplenotepad/app/routes/app_pages.dart';
import 'package:simplenotepad/app/utils/themes/color_themes.dart';

import '../controllers/auth_login_controller.dart';
import 'widgets/login_text_field.dart';

class AuthLoginView extends getx.GetView<AuthLoginController> {
  const AuthLoginView({super.key});
  @override
  Widget build(BuildContext context) {
    debugPrint('orientation: ${MediaQuery.of(context).orientation}');
    debugPrint('context height: ${context.height}');
    debugPrint('context width: ${context.width}');
    debugPrint('context textfield height true: ${getx.Get.height * 0.07}');
    debugPrint('context textfield height false: ${getx.Get.height * 0.10}');
    debugPrint('Current layout: ${ResponsiveValue(context, conditionalValues: [
          Condition.largerThan(
              name: MOBILE,
              value: ResponsiveRowColumnType.COLUMN,
              landscapeValue: ResponsiveRowColumnType.COLUMN)
        ], defaultValue: ResponsiveRowColumnType.COLUMN).value}');
    // controller.isButtonValid.value = false;
    controller.loginButtonValidation();
    return Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SafeArea(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: context.height, minWidth: context.width),
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
                  ResponsiveRowColumnItem(child: getx.Obx(
                    () {
                      controller.loginButtonValidation();
                      return ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                  controller.loginButtonValidation().isFalse
                                      ? AppColor.primarySecondDisableColor
                                      : AppColor.primarySecondColor),
                              shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10).w)),
                              minimumSize: WidgetStatePropertyAll(
                                  Size(context.width, 40.h))),
                          onPressed: () {
                            debugPrint('${controller.isButtonValid.value}');
                            controller.loginButtonValidation().isFalse
                                ? null
                                : controller.isLoading.isFalse
                                    ? controller.loginUser(
                                        controller.emailController.text,
                                        controller.passwordController.text)
                                    : null;
                          },
                          child: controller.isLoading.isTrue
                              ? CircularProgressIndicator()
                              : Text(
                                  "Login",
                                  style: TextStyle(
                                      color: AppColor.backgroundColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold),
                                ));
                    },
                  )),
                  ResponsiveRowColumnItem(
                    child: SizedBox(
                      width: 1.sw,
                      child: Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(children: [
                            TextSpan(
                                text: "Don't have an account? ",
                                style: TextStyle(
                                    color: AppColor.secondaryColor,
                                    fontSize: 12.sp)),
                            TextSpan(
                                text: "Sign up for free",
                                style: TextStyle(
                                    color: AppColor.primarySecondColor,
                                    fontSize: 12.sp,
                                    decoration: TextDecoration.underline,
                                    decorationColor:
                                        AppColor.primarySecondColor),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () =>
                                      getx.Get.toNamed(Routes.AUTH_REGISTER))
                          ])),
                    ),
                  ),
                  ResponsiveRowColumnItem(
                      child: Container(
                    alignment: Alignment.bottomRight,
                    child: SvgPicture.asset(
                      'assets/svg/login_illust.svg',
                      fit: BoxFit.cover,
                      height: 250.r,
                      width: 250.r,
                    ),
                  ))
                ],
              ),
            ),
          ),
        ));
  }
}
