import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthProvider extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final storage = new FlutterSecureStorage();

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final idToken = await credential.user?.getIdToken();
      await storage.write(key: 'token', value: idToken, aOptions: _getAndroidOptions());
      notifyListeners();
      return credential.user;
    } catch (e) {
      print("Some error occured: ");
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final idToken = await credential.user?.getIdToken();
      await storage.write(key: 'token', value: idToken, aOptions: _getAndroidOptions());
      notifyListeners();
      return credential.user;
    } catch (e) {
      print("Some error occured: ${e} ");
      throw e;
    }
    return null;
  }
  
  
  signInWithGoogle() async {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  User? getUser() {
    return _auth.currentUser;
  }

  Future logout() async {
    await storage.delete(key: 'token', aOptions: _getAndroidOptions());
    return;
  }

  Future<String> readToken() async {
    Map<String, String> allValues = await storage.readAll(
      aOptions: _getAndroidOptions());
    return await storage.read(key: 'token', aOptions: _getAndroidOptions()) ?? '';
  
  }

 AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );

}
