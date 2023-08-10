import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Authservice extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<UserCredential> signIn(String email, String password) async {
    UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);

    firebaseFirestore.collection("users").doc(userCredential.user!.uid).set(
        {"email": email, "uid": userCredential.user!.uid},
        SetOptions(merge: true));

    return userCredential;
  }

  Future<void> signuserOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> update(uid, username) async {
    await firebaseFirestore
        .collection('users')
        .doc(uid)
        .update({"BIO": username.toString()});
  }
  Future<void> usernameupdate(uid, newusername) async {
    await firebaseFirestore
        .collection('users')
        .doc(uid)
        .update({"username": newusername.toString()});
  }

  

  Future<UserCredential> Signupwithemailandpassword(
      String email, String password) async {
    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    firebaseFirestore.collection("users").doc(userCredential.user!.uid).set({
      "email": email,
      "uid": userCredential.user!.uid,
      "username": email.substring(0, email.indexOf("@")),
      "BIO": "'Hi there! I'm using MyChat'",
      'imageurl':["https://www.flaticon.com/free-icons/user" ]
      

    }, SetOptions(merge: true));

    return userCredential;
  }
}
