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
    required String type,
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
            password: password,
            uid: cred.user!.uid,
            username: username,
            type: type);
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

  Future<String> savepenalty({
    required String text,
  }) async {
    String res = "Some error occured";

    try {
      if (text.isNotEmpty) {
        //register user
        DateTime now = DateTime.now();
        String formattedDate =
            "${now.year}-${now.month}-${now.day}-${now.hour}-${now.minute}-${now.second}";

        model.rules user =
            model.rules(formattedDate: formattedDate, text: text);
        await _firestore.collection('penalty').doc(formattedDate).set(
              user.toJson(),
            );
        res = "Success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> saveroom({
    required String id,
    required String corry,
    required String floor,
  }) async {
    String res = "Some error occured";

    try {
      if (id.isNotEmpty && corry.isNotEmpty && floor.isNotEmpty) {
        //register user

        model.room user = model.room(id: id, corry: corry, floor: floor);
        await _firestore.collection('Rooms').doc(id).set(
              user.toJson(),
            );
        res = "Success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //push notification
  Future<String> push_notification({
    required String text,
    required String duedate,
    required String duetime,
    required String selectedtype,
  }) async {
    String res = "Some error occured";

    try {
      if (text.isNotEmpty && duedate.isNotEmpty) {
        //register user
        DateTime now = DateTime.now();
        String formattedDate =
            "${now.year}-${now.month}-${now.day}-${now.hour}-${now.minute}-${now.second}";

        model.notification user = model.notification(
          duetime: duetime,
          duedate: duedate,
          formattedDate: formattedDate,
          text: text,
          selectedtype: selectedtype,
        );
        await _firestore.collection('notification').doc(formattedDate).set(
              user.toJson(),
            );
        res = "Success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> saverules({
    required String text,
  }) async {
    String res = "Some error occured";

    try {
      if (text.isNotEmpty) {
        //register user
        DateTime now = DateTime.now();
        String formattedDate =
            "${now.year}-${now.month}-${now.day}-${now.hour}-${now.minute}-${now.second}";

        model.rules user =
            model.rules(formattedDate: formattedDate, text: text);
        await _firestore.collection('rules').doc(formattedDate).set(
              user.toJson(),
            );
        res = "Success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // complint registration
  Future<String> complint_registration({
    required String title,
    required String discription,
    required Uint8List file,
  }) async {
    String res = "Some error occured";

    try {
      if (title.isNotEmpty && discription.isNotEmpty && file.isNotEmpty) {
        //register user
        DateTime now = DateTime.now();
        String formattedDate =
            "${now.year}-${now.month}-${now.day}-${now.hour}-${now.minute}-${now.second}";
        String uid = FirebaseAuth.instance.currentUser!.uid;
        String photourl = await Storagemethods()
            .uploadImageToStorage('complaints', file, false);
        //add user to database

        model.complaints user = model.complaints(
            formattedDate: formattedDate,
            title: title,
            photourl: photourl,
            uid: uid,
            discription: discription);
        await _firestore.collection('complaints').doc(formattedDate).set(
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
      {required String email,
      required String password,
      required String type}) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        String userId = userCredential.user!.uid;

        final CollectionReference usersRef =
            FirebaseFirestore.instance.collection('users');
        final DocumentSnapshot userDoc = await usersRef.doc(userId).get();
        if (userDoc.exists) {
          print("------------------");
          final userData = userDoc.data() as Map<String, dynamic>?;
          final String? userType = userData?['type'];
          if (userType == type) {
            print('jisha');
            print(userId);
            res = "Success";
          }
        } else {
          print("+++++++++++++");
          throw FirebaseAuthException(
              code: 'user-not-found', message: 'User not found');
        }
      } else {
        res = "Please enter all fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
