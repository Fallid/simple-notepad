import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:simplenotepad/app/modules/bindings/initial_bindings.dart';
import 'package:simplenotepad/app/utils/dimension/screen_dimension.dart';
import 'package:simplenotepad/app/utils/themes/color_themes.dart';
import 'package:simplenotepad/firebase_options.dart';

import 'app/routes/app_pages.dart';
import 'generated/locales.g.dart';

Future<void> main() async {
  debugPaintSizeEnabled = false;
  // debugPaintPointersEnabled= true;
  debugRepaintRainbowEnabled= false;
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
        initialBinding: InitialBindings(),
        title: "Simple Note",
        translationsKeys: AppTranslation.translations,
        locale: Get.deviceLocale ?? Locale('en', 'US'),
        fallbackLocale: Locale('en', 'US'),
        builder: (context, child) => appBuilder(context, child),
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      ),
    )
  );
}

Widget appBuilder(BuildContext context, Widget? child) {
  return Container(
    color: AppColor.backgroundColor,
    child: ResponsiveBreakpoints.builder(
        breakpointsLandscape: ScreenDimension.breakpointsLandscape,
        breakpoints: ScreenDimension.breakpoint,
        child: ClampingScrollWrapper.builder(
            context,
            MaxWidthBox(
                maxWidth: 1200,
                child: child!))),
  );
}
