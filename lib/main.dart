import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:simplenotepad/app/utils/dimension/screen_dimension.dart';

import 'app/routes/app_pages.dart';
import 'generated/locales.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        title: "Simple Note",
        translationsKeys: AppTranslation.translations,
        locale: Locale('en','US'),
        fallbackLocale: Locale('en','US'),
        builder: (context, child) => ResponsiveBreakpoints.builder(
            breakpoints: ScreenDimension.breakpoint, child: child!),
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      ),
    ),
  );
}
