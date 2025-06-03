import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageController extends GetxService {
  void toggleLocale() {
    Locale currentLocale =
        Get.locale ?? Get.fallbackLocale ?? Locale('en', 'US');

    if (currentLocale.languageCode == 'id') {
      // Jika saat ini bahasa Indonesia, ganti ke bahasa Inggris
      Get.updateLocale(Locale('en', 'US'));
    } else {
      // Jika bukan bahasa Indonesia, ganti ke bahasa Indonesia
      Get.updateLocale(Locale('id', 'ID'));
    }
  }
}
