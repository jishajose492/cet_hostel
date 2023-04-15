import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String phone;
  final String username;
  final String photourl;
  final String password;

  const User({
    required this.email,
    required this.phone,
    required this.photourl,
    required this.uid,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'phone': phone,
        'email': email,
        'photourl': photourl,
        'password': password,
      };
  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      username: snapshot['username'],
      uid: snapshot['uid'],
      email: snapshot['email'],
      phone: snapshot['phone'],
      photourl: snapshot['photourl'],
      password: snapshot['password'],
    );
  }
}

class complaints {
  final String title;
  final String uid;
  final String discription;
  final String formattedDate;

  final String photourl;

  const complaints({
    required this.title,
    required this.formattedDate,
    required this.uid,
    required this.photourl,
    required this.discription,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'userid': uid,
        'discription': discription,
        'image': photourl,
        'rtext': "",
        'status': "waiting for student admin",
        'time': formattedDate
      };
}
