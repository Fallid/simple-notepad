import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simplenotepad/app/data/models/user_model.dart';
import 'package:simplenotepad/app/data/providers/authentication_provider.dart';
import 'package:simplenotepad/app/data/providers/user_provider.dart';

class HomeController extends GetxController {
  final AuthenticationProvider _authenticationProvider =
      Get.find<AuthenticationProvider>();
  final UserProvider _userProvider = Get.find<UserProvider>();
  final Rx<UserModel?> currentUserData = Rx<UserModel?>(null);
  final RxBool isUserProfileLoading = false.obs;

  final RxString _searchText = ''.obs;

  final TextEditingController _searchController = TextEditingController();

  String get getPhotoUrl => _userProvider.getPhotoUrl();
  String get getDisplayName => _userProvider.getDisplayName();
  @override
  void onInit() {
    super.onInit();
    currentUserData.bindStream(_userProvider.currentUserModel.stream);
    isUserProfileLoading.bindStream(_userProvider.isProfileDataLoading.stream);
    _searchController.addListener(() {
      getSearchText.value = _searchController.text.trim();
    });
  }

  @override
  void onReady() {
    if (_authenticationProvider.firebaseAuth.currentUser != null) {
      _userProvider.listenToCurrentUserProfile(
          _authenticationProvider.firebaseAuth.currentUser!.uid);
    }
    super.onReady();
  }

  @override
  void onClose() {
    _userProvider.stopListeningToCurrentUserProfile();
    _searchController.dispose();
    super.onClose();
  }

  TextEditingController get searchController => _searchController;

  RxString get getSearchText => _searchText;

  void clearSearch() {
    _searchController.clear();
    Get.focusScope?.unfocus();
  }
}
