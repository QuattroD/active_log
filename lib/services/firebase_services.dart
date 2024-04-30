import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'user_model.dart';

class FirebaseService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
// Регистрация
  Future<UserModel?> signUp(String name, String email, String password) async {
    try {
      UserCredential result =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseFirestore.instance
          .collection(
              'User${FirebaseAuth.instance.currentUser!.email.toString()}')
          .doc('UserInfo')
          .set({'name': name, 'email': email, 'password': password});
      User user = result.user as User;
      return UserModel.fromFirebase(user);
    } catch (e) {
      return null;
    }
  }

  // авторизация
  Future<UserModel?> signIn(String email, String password) async {
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user as User;

      return UserModel.fromFirebase(user);
    } catch (e) {
      return null;
    }
  }

  Future logOut() async {
    await _firebaseAuth.signOut();
  }

  Stream<UserModel?> get currentUser {
    return _firebaseAuth.authStateChanges().map(
        (User? user) => user != null ? UserModel.fromFirebase(user) : null);
  }
}
