import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simplenotepad/app/data/language.dart';
import 'package:simplenotepad/app/data/models/user_model.dart';
import 'package:simplenotepad/app/data/providers/authentication_provider.dart';
import 'package:simplenotepad/app/data/providers/user_provider.dart';
import 'package:simplenotepad/app/utils/dimension/screen_dimension.dart';

class ProfileController extends GetxController {
  final AuthenticationProvider _authenticationProvider =
      Get.find<AuthenticationProvider>();
  final UserProvider _userProvider = Get.find<UserProvider>();
  final LanguageController _languageController = Get.find<LanguageController>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final RxString _nameValue = ''.obs;
  final RxString _emailValue = ''.obs;
  final RxString _newPasswordValue = ''.obs;
  final RxString _confirmPasswordValue = ''.obs;
  final RxBool isLoading = false.obs;
  final Rx<File?> _selectedImageFile = Rx<File?>(null);
  final Rx<User?> firebaseUser = Rx<User?>(null);
  final Rx<UserModel?> userModel = Rx<UserModel?>(null);

  LanguageController get languageController => _languageController;
  TextEditingController get nameController => _nameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _newPasswordController;
  TextEditingController get confirmPassowrdController =>
      _confirmPasswordController;

  RxString get nameValue => _nameValue;
  RxString get emailValue => _emailValue;
  RxString get newPasswordValue => _newPasswordValue;
  RxString get confirmPasswordValue => _confirmPasswordValue;
  String get getPhoto => _userProvider.getPhotoUrl();
  String get getDisplayName => _userProvider.getDisplayName();
  String get getEmail => _userProvider.getEmail();
  File? get selectedImageFile => _selectedImageFile.value;
  Future get logout {
    return _authenticationProvider.signOut();
  }

  @override
  void onInit() {
    super.onInit();
    _nameController
        .addListener(() => nameValue.value = _nameController.text.trim());
    _emailController
        .addListener(() => emailValue.value = _emailController.text.trim());
    _newPasswordController.addListener(
        () => newPasswordValue.value = _newPasswordController.text.trim());
    _confirmPasswordController.addListener(() =>
        confirmPasswordValue.value = _confirmPasswordController.text.trim());

    firebaseUser.bindStream(_authenticationProvider.authStateChanges);
    ever(firebaseUser, (_) {
      if (firebaseUser.value != null) {
        _userProvider.listenToCurrentUserProfile(firebaseUser.value!.uid);
        userModel.bindStream(
            _userProvider.getUserDocument(firebaseUser.value!.uid).map((doc) {
          if (doc.exists && doc.data() != null) {
            return UserModel.fromFirestore(doc);
          }
          return null;
        }));
      } else {
        userModel.value = null;
        _selectedImageFile.value = null; // Reset gambar lokal jika logout
      }
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
    super.onClose();
    _nameController.dispose();
    _emailController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
  }

  Future<XFile?> pickImageFromSource(ImageSource source) async {
    return _userProvider.pickImageFromSource(source);
  }

  double? mainAxisExtent(BuildContext context) {
    return ScreenDimension.isMobile(context)
        ? 50.w
        : ScreenDimension.isTablet(context)
            ? 48.w
            : ScreenDimension.isDesktop(context)
                ? 40.w
                : null;
  }

  Future<void> pickAndDisplayLocalImage() async {
    ImageSource? selectedSource = await Get.bottomSheet<ImageSource>(
      Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Ambil dari Kamera'),
              onTap: () {
                Get.back(result: ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Pilih dari Galeri'),
              onTap: () {
                Get.back(result: ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
      elevation: 20.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );

    if (selectedSource == null) {
      return; // Pengguna membatalkan pemilihan sumber
    }

    // Panggil UserProvider untuk memilih gambar
    final XFile? image =
        await _userProvider.pickImageFromSource(selectedSource);

    if (image != null) {
      _selectedImageFile.value =
          File(image.path); // Simpan file lokal yang dipilih
    } else {
      _selectedImageFile.value =
          null; // Reset jika pemilihan dibatalkan atau gagal
    }
  }

  Future<void> uploadAndUpdateProfilePicture() async {
    if (_selectedImageFile.value == null) {
      Get.snackbar('Informasi', 'Pilih gambar terlebih dahulu untuk diupdate.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue,
          colorText: Colors.white);
      return;
    }

    isLoading.value = true; // Aktifkan state loading untuk upload foto

    try {
      // 1. Unggah gambar ke Firebase Storage (menggunakan file lokal yang disimpan)
      final String downloadUrl = await _userProvider.uploadProfilePicture(
        firebaseUser.value!.uid,
        XFile(_selectedImageFile
            .value!.path), // Convert File to XFile for provider
      );

      // 2. Perbarui photoUrl di Firebase Authentication
      await _authenticationProvider.updateAuthPhotoUrl(downloadUrl);

      // 3. Perbarui photoUrl di Firestore
      await _userProvider.updateUserFirestore(
        firebaseUser.value!.uid,
        {
          'photoUrl': downloadUrl,
          'updatedAt': FieldValue.serverTimestamp(),
        },
      );

      _selectedImageFile.value =
          null; // Reset gambar lokal setelah berhasil diupload
      Get.snackbar('Berhasil', 'Foto profil berhasil diperbarui!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
          'Error Autentikasi', e.message ?? 'Terjadi kesalahan autentikasi.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } on FirebaseException catch (e) {
      Get.snackbar(
          'Error Firebase', e.message ?? 'Terjadi kesalahan pada Firebase.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan tidak terduga: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      isLoading.value = false; // Nonaktifkan state loading
    }
  }
}
