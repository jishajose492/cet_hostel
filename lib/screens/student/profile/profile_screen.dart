import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cet_hostel/screens/login_screen.dart';

import 'package:cet_hostel/screens/student/profile/menu_preference.dart';
import 'package:cet_hostel/screens/student/profile/update_profile_screen.dart';
import 'package:cet_hostel/utils/colors.dart';
import 'package:cet_hostel/utils/text_screen.dart';
import 'package:cet_hostel/widgets/profile_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:cet_hostel/models/user.dart' as model;

String username = "";
String photo = "";
String email = "";
String phone = "";
String pp = "";

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    getUserdetails();

    super.initState();
  }

  Future<String> getUserdetails() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        username = documentSnapshot.get('username');
        photo = documentSnapshot.get('photourl').toString();
        email = documentSnapshot.get('email');
        print("hi");
        print(photo);
        pp = photo;
      } else {
        print("not exist");
      }
    });
    return username;
  }

  final _collectionRef = FirebaseFirestore.instance;

  void logout() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.signOut();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (builder) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    //var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: null,

        // leading: IconButton(
        //   onPressed: () {},
        //   icon: const Icon(
        //     LineAwesomeIcons.angle_left,
        //     color: Colors.black,
        //   ),
        // ),

        title: Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
          // style: Theme.of(context).textTheme.headlineSmall,
        ),
        centerTitle: true,
      ),
      // actions: [
      //   IconButton(
      //     onPressed: () {},
      //     icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon),
      //   ),
      // ],

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),

              StreamBuilder(
                stream: _collectionRef
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                        child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.green)));
                  } else {
                    return Container(
                      child: CircleAvatar(
                        radius: 80.0,
                        backgroundImage:
                            NetworkImage(snapshot.data.get('photourl')),
                      ),
                    );
                  }
                },
              ),
              SizedBox(
                height: 24,
              ),
              StreamBuilder(
                stream: _collectionRef
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                        child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.green)));
                  } else {
                    return Text(
                      snapshot.data.get('username'),
                      style: TextStyle(
                          fontSize: 20,
                          color: const Color.fromARGB(255, 22, 22, 22)),
                    );
                  }
                },
              ),

              SizedBox(
                height: 10,
              ),
              Text(
                "22LH032",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 22, 22, 22),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const UpdateProfileScreen()));
                  },
                  child: Text(
                    "Edit Profile",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 80, 80, 80),
                    side: BorderSide.none,
                    shape: StadiumBorder(),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),

              //MENU
              Profilewidget(
                title: "View Attendance",
                icon: Icons.check_box,
                onPress: () {},
              ),
              Profilewidget(
                title: "View MessBill",
                icon: Icons.wallet,
                onPress: () {},
              ),
              Profilewidget(
                title: "Menu Preference",
                icon: Icons.restaurant,
                onPress: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const MenuPreferenceScreen()));
                },
              ),
              Profilewidget(
                title: "Logout",
                textcolor: Colors.red,
                icon: LineAwesomeIcons.alternate_sign_out,
                onPress: logout,
              ),
            ],
          ),
          // // ),
        ),
      ),
    );
  }
}
