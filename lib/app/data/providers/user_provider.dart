import 'dart:io'; // Untuk File
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserProvider extends GetxService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  FirebaseFirestore get firestore => _firestore;
  FirebaseStorage get storage => _storage;
  ImagePicker get picker => _picker;

  Future<XFile?> pickImageFromGallery() async {
    return await _picker.pickImage(source: ImageSource.gallery);
  }

  Future<String> uploadProfilePicture(String uid, XFile imageFile) async {
    File file = File(imageFile.path);
    // Path di Storage: 'profile_pictures/{UID_user}/{timestamp}.jpg'
    final String fileName = '$uid/${DateTime.now().millisecondsSinceEpoch}.jpg';
    final Reference storageRef = _storage.ref().child('profile_pictures').child(fileName);

    UploadTask uploadTask = storageRef.putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  // Metode untuk memperbarui data pengguna di Cloud Firestore.
  Future<void> updateUserFirestore(String uid, Map<String, dynamic> data) async {
    await _firestore.collection('users').doc(uid).update(data);
  }

  // Metode untuk memberikan pembaruan real-time data pengguna dari Cloud Firestore.
  Stream<DocumentSnapshot> getUserStream(String uid) {
    return _firestore.collection('users').doc(uid).snapshots();
  }

  // Metode untuk membuat dokumen pengguna baru di Firestore (biasanya saat registrasi).
  Future<void> createUserFirestore(String uid, Map<String, dynamic> data) async {
    await _firestore.collection('users').doc(uid).set(data);
  }
}
