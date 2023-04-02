import 'dart:typed_data';

import 'package:cet_hostel/models/user.dart' as model;
import 'package:cet_hostel/resources/storage_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<model.User> getUserdetails() async {
    print("9");
    User currentUser = _auth.currentUser!;
    print("10");
    print(currentUser);
    print("11");
    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();
    print(snap.data());
    return model.User.fromSnap(snap);
  }

  //signupuser
  Future<String> SignUpUser({
    required String email,
    required String password,
    required String username,
    required String phone,
    required Uint8List file,
  }) async {
    String res = "Some error occured";
    print("hello");
    try {
      print('yesi');
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          phone.isNotEmpty &&
          file.isNotEmpty) {
        //register user
        print("hi");
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);
        String photourl = await Storagemethods()
            .uploadImageToStorage('Profilepics', file, false);
        //add user to database

        model.User user = model.User(
            email: email,
            phone: phone,
            photourl: photourl,
            uid: cred.user!.uid,
            username: username);
        await _firestore.collection('users').doc(cred.user!.uid).set(
              user.toJson(),
            );
        res = "Success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //logging in user
  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "Success";
      } else {
        res = "Please enter all fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
