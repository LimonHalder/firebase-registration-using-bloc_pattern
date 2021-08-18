import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_registration_using_bloc/home_screen.dart';

import 'package:flutter/material.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepository({FirebaseAuth firebaseAuth}) : _firebaseAuth =firebaseAuth ?? FirebaseAuth.instance;

  Future<void> signInWithCredentials(String email, String password) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signUp(String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    return Future.wait([_firebaseAuth.signOut()]);
  }

  Future<bool> isSignedIn() async {
    var firebaseUser = await _firebaseAuth.currentUser();
    return firebaseUser != null;
  }

  Future<bool> isVerified() async {
    var firebaseUser = await _firebaseAuth.currentUser();

    firebaseUser.isEmailVerified;
    firebaseUser.reload();
  }

  Future<FirebaseUser> getUser() async {
    return await _firebaseAuth.currentUser();
  }

  Future<void> checkEmailVerified() async {
    final firebaseUser = await _firebaseAuth.currentUser();
    firebaseUser.sendEmailVerification();
    firebaseUser.reload();
  }
  //Future<bool> verified() async {
  //final firebaseUser = await _firebaseAuth.currentUser();
  //return firebaseUser.isEmailVerified;

}
