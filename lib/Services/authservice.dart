import 'package:firebase_auth/firebase_auth.dart';

class Authservice {
  final _auth = FirebaseAuth.instance;
  Future<User?> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak Password') {
        throw Exception('Password is too weak, please use a stronger password');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      } else if (e.code == 'invalid-email') {
        throw Exception('The email address is not valid.');
      } else if (e.code == 'operation-not-allowed') {
        throw Exception('Email/password accounts are not enabled.');
      } else {
        throw Exception('An error occurred: ${e.message}');
      }
    }
  }

  Future<User?> signInUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'User not found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'Wrong password') {
        throw Exception('Wrong password provided for that user.');
      } else if (e.code == 'invalid-email') {
        throw Exception('The email address is not valid.');
      } else {
        throw Exception('An error occurred: ${e.message}');
      }
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception('An error occured: ${e.toString()}');
    }
  }
}
