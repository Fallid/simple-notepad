import 'dart:io'; // Untuk File
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simplenotepad/app/data/models/user_model.dart';

class UserProvider extends GetxService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();
  final Rx<UserModel?> _userModel = Rx<UserModel?>(null);
  final RxBool isProfileDataLoading = false.obs;

  FirebaseFirestore get firestore => _firestore;
  FirebaseStorage get storage => _storage;
  ImagePicker get picker => _picker;

  Rx<UserModel?> get currentUserModel =>
      _userModel; 

  String getDisplayName() {
    return _userModel.value?.name ?? 'Pengguna';
  }

  String getEmail() {
    return _userModel.value?.email ?? 'Tidak ada email';
  }

  String getPhotoUrl() {
    return _userModel.value?.photoUrl ?? '';
  }

 void listenToCurrentUserProfile(String uid) {
    isProfileDataLoading.value = true; 
    _userModel.bindStream(getUserDocument(uid).map((doc) {
      isProfileDataLoading.value = false; 
      if (doc.exists && doc.data() != null) {
        return UserModel.fromFirestore(doc);
      } else {
        debugPrint("Dokumen pengguna tidak ditemukan untuk UID: $uid");
        return null;
      }
    }));
  }

  void stopListeningToCurrentUserProfile() {
    _userModel.value = null; 
    isProfileDataLoading.value = false; 
    // _userModel.close();
  }

  Future<XFile?> pickImageFromGallery() async {
    return await _picker.pickImage(source: ImageSource.gallery);
  }

  Future<String> uploadProfilePicture(String uid, XFile imageFile) async {
    File file = File(imageFile.path);
    // Path di Storage: 'profile_pictures/{UID_user}/{timestamp}.jpg'
    final String fileName = '$uid/${DateTime.now().millisecondsSinceEpoch}.jpg';
    final Reference storageRef =
        _storage.ref().child('profile_pictures').child(fileName);

    UploadTask uploadTask = storageRef.putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  Future<void> updateUserFirestore(
      String uid, Map<String, dynamic> data) async {
    await _firestore.collection('users').doc(uid).update(data);
  }

  Stream<DocumentSnapshot> getUserDocument(String uid) {
    return _firestore.collection('users').doc(uid).snapshots();
  }

  Future<void> createUserFirestore(
      String uid, Map<String, dynamic> data) async {
    await _firestore.collection('users').doc(uid).set(data);
  }
}
