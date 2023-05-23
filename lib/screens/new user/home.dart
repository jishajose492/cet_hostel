import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class newhome extends StatefulWidget {
  @override
  State<newhome> createState() => _newhomeState();
}

class _newhomeState extends State<newhome> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Pages Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Assuming you have already initialized Firebase
    // and obtained the Firestore instance.
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String user = FirebaseAuth.instance.currentUser!.uid;

    return FutureBuilder<DocumentSnapshot>(
      future: firestore.collection('usersnew').doc(user).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (snapshot.hasData) {
            var data = snapshot.data!.data() as Map<String, dynamic>;
            var fieldValue =
                data['status']; // Replace 'field' with your actual field name

            // Conditionally navigate based on the field value
            if (fieldValue == 'Applied For Hostal') {
              return Container(
                child: Text("hi"),
              );
            } else if (fieldValue == 'Hostall alotted') {
              return Container(
                child: Text("meme"),
              );
            } else if (fieldValue == 'roomalotted') {
              //return HomePage(bar: 1);
              return Container(
                child: Text("bar"),
              );
            } else {
              return Container(
                child: CircularProgressIndicator(),
              );
            }
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text('Error retrieving data from Firebase'),
              ),
            );
          } else {
            return Scaffold(
              body: Center(
                child: Text('No data available in Firebase'),
              ),
            );
          }
        }
      },
    );
  }
}
