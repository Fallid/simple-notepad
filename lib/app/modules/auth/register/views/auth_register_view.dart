import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart' as getx;
import 'package:responsive_framework/responsive_framework.dart';
import 'package:simplenotepad/app/modules/auth/register/views/widgets/register_text_field.dart';
import 'package:simplenotepad/app/modules/auth/widgets/authentication_button.dart';
import 'package:simplenotepad/app/utils/themes/color_themes.dart';

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
                    Text(
                      'Create your account',
                      style: TextStyle(fontSize: 20.sp, color: Colors.white),
                    ),
                    10.verticalSpace,
                    Text(
                      "Enter the fields below to get started",
                      style: TextStyle(fontSize: 11.sp, color: Colors.white),
                    ),
                    20.verticalSpace
                  ],
                )),
                ResponsiveRowColumnItem(
                    child: RegisterTextField(
                        contentPaddingLeft: 10,
                        contentPaddingRight: 10,
                        controller: controller,
                        title: "Name",
                        registerHintText: "Jhon due",
                        isFieldValid: controller.isNameValid,
                        validationType: ValidationType.name)),
                ResponsiveRowColumnItem(
                    child: RegisterTextField(
                        contentPaddingLeft: 10,
                        contentPaddingRight: 10,
                        controller: controller,
                        title: "Email",
                        registerHintText: "example@mail.com",
                        isFieldValid: controller.isEmailValid,
                        validationType: ValidationType.email)),
                ResponsiveRowColumnItem(
                    child: RegisterTextField(
                        contentPaddingTop: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? 10
                            : 5,
                        contentPaddingLeft: 10,
                        contentPaddingRight: 10,
                        controller: controller,
                        title: "Password",
                        registerHintText: "*****",
                        isFieldValid: controller.isEmailValid,
                        validationType: ValidationType.password)),
                ResponsiveRowColumnItem(
                  child: RegisterLoginTextButton(
                    message: "Already have an account? ",
                    textButton: "Sign in here",
                    onTap: () => getx.Get.back(),
                  ),
                ),
                ResponsiveRowColumnItem(
                    child: AuthenticationButton(
                        buttonValidation: controller.buttonValidation(),
                        isLoading: controller.isLoading,
                        onPressed: controller.registerUser,
                        title: "Register")),
                ResponsiveRowColumnItem(
                    child: Container(
                  alignment: Alignment.bottomRight,
                  child: SvgPicture.asset(
                    'assets/svg/register_illust.svg',
                    fit: BoxFit.cover,
                    height: 200.r,
                    width: 200.r,
                  ),
                ))
              ],
            ),
          )),
        ));
  }
}
