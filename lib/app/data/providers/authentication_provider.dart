import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthenticationProvider extends GetxService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  FirebaseAuth get firebaseAuth => _firebaseAuth;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> updateAuthPhotoUrl(String photoUrl) async {
    await _firebaseAuth.currentUser?.updatePhotoURL(photoUrl);
    await _firebaseAuth.currentUser?.reload();
  }

  Future<UserCredential> signIn(String email, String password) async {
    return await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> signUp(String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}