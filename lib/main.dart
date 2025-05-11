import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:simplenotepad/app/utils/dimension/screen_dimension.dart';
import 'package:simplenotepad/firebase_options.dart';

import 'app/routes/app_pages.dart';
import 'generated/locales.g.dart';

Future<void> main() async {
  debugPaintSizeEnabled = true;
  // debugPaintPointersEnabled= true;
  // debugRepaintRainbowEnabled= true;
  debugPaintLayerBordersEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(
    ScreenUtilInit(
      designSize: ScreenUtil.defaultSize,
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
