import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

final profileRef = FirebaseFirestore.instance.collection('Profile');
var globFullName;
var globMobileNum;
var globURL_Image;
var globHobbies;
var globValid;

class Storage {
  readDataBase() async {
    final docRef = await profileRef.doc('user_profile').get();
    Map<String, dynamic>? data = docRef.data();
    globFullName = data?['full_name'];
    globMobileNum = data?['mobile_phone'];
    globHobbies = data?['hobbies'];
    globURL_Image = data?['url_image'];
    globValid = data?['has_profile'];
  }

  writeURL(String url) {
    url = globURL_Image;
  }

  readURL() {
    return globURL_Image;
  }

  readUserName() {
    return globFullName;
  }

  readMobileNum() {
    return globMobileNum;
  }

  readHobbies() {
    return globHobbies;
  }
}
