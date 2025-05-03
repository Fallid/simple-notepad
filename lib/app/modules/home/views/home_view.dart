import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:simplenotepad/generated/locales.g.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              LocaleKeys.buttons_login.tr,
              style: TextStyle(fontSize: 20.sp),
            ),
            SizedBox(height: 1.h, width: 1.w,),
            ElevatedButton(onPressed: (){Get.updateLocale(Locale('id','ID'));}, child: Text("Indonesia"))
          ],
        ),
      ),
    );
  }
}
