import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String phone;
  final String username;
  final String photourl;
  final String district;
  final String income;
  final String status;
  final String totel;

  const User(
      {required this.email,
      required this.phone,
      required this.photourl,
      required this.uid,
      required this.username,
      required this.district,
      required this.income,
      required this.status,
      required this.totel});

  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'phone': phone,
        'email': email,
        'photourl': photourl,
        'roomid': "",
        'district': district,
        'income': income,
        'status': status,
        'totel': totel,
      };
  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
        username: snapshot['username'],
        uid: snapshot['uid'],
        email: snapshot['email'],
        phone: snapshot['phone'],
        photourl: snapshot['photourl'],
        district: snapshot['district'],
        income: snapshot['income'],
        status: snapshot['status'],
        totel: snapshot['totel']);
  }
}

// class User {
//   final String email;
//   final String uid;
//   final String phone;
//   final String username;
//   final String photourl;
//   final String password;
//   final String type;

//   const User({
//     required this.email,
//     required this.phone,
//     required this.photourl,
//     required this.uid,
//     required this.username,
//     required this.password,
//     required this.type,
//   });

//   Map<String, dynamic> toJson() => {
//         'username': username,
//         'uid': uid,
//         'phone': phone,
//         'email': email,
//         'photourl': photourl,
//         'password': password,
//         'type': type,
//       };
//   static User fromSnap(DocumentSnapshot snap) {
//     var snapshot = snap.data() as Map<String, dynamic>;
//     return User(
//       username: snapshot['username'],
//       uid: snapshot['uid'],
//       email: snapshot['email'],
//       phone: snapshot['phone'],
//       photourl: snapshot['photourl'],
//       password: snapshot['password'],
//       type: snapshot['type'],
//     );
//   }
// }
// class User {
//   final String email;
//   final String uid;
//   final String phone;
//   final String type;
//   final String username;
//   final String photourl;
//   final String password;
//   final String district;
//   final String pl;

//   final String income;
//   final String status;
//   final String totel;

//   const User(
//       {required this.email,
//       required this.phone,
//       required this.photourl,
//       required this.password,
//       required this.uid,
//       required this.username,
//       required this.district,
//       required this.pl,
//       required this.income,
//       required this.status,
//       required this.totel,
//       required this.type});

//   Map<String, dynamic> toJson() => {
//         'username': username,
//         'uid': uid,
//         'phone': phone,
//         'email': email,
//         'photourl': photourl,
//         'password': password,
//         'roomid': "",
//         'pl': pl,
//         'district': district,
//         'income': income,
//         'status': status,
//         'totel': totel,
//       };
//   static User fromSnap(DocumentSnapshot snap) {
//     var snapshot = snap.data() as Map<String, dynamic>;
//     return User(
//         username: snapshot['username'],
//         uid: snapshot['uid'],
//         email: snapshot['email'],
//         phone: snapshot['phone'],
//         photourl: snapshot['photourl'],
//         type: snapshot['type'],
//         password: snapshot['password'],
//         district: snapshot['district'],
//         pl: snapshot['pl'],
//         income: snapshot['income'],
//         status: snapshot['status'],
//         totel: snapshot['totel']);
//   }
// }

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

class notification {
  final String text;
  final String formattedDate;
  final String duedate;
  final String duetime;
  final String selectedtype;

  const notification({
    required this.text,
    required this.formattedDate,
    required this.duedate,
    required this.duetime,
    required this.selectedtype,
  });

  Map<String, dynamic> toJson() => {
        'text': text,
        'time': formattedDate,
        'duedate': duedate,
        'duetime': duetime,
        'selectedtype': selectedtype,
      };
}

class rules {
  final String text;
  final String formattedDate;

  const rules({
    required this.text,
    required this.formattedDate,
  });

  Map<String, dynamic> toJson() => {
        'text': text,
        'time': formattedDate,
      };
}

class penalty {
  final String text;
  final String formattedDate;

  const penalty({
    required this.text,
    required this.formattedDate,
  });

  Map<String, dynamic> toJson() => {
        'text': text,
        'time': formattedDate,
      };
}

class room {
  final String id;
  final String corry;
  final String floor;

  const room({
    required this.id,
    required this.corry,
    required this.floor,
  });

  Map<String, dynamic> toJson() => {
        'roomid': id,
        'corry': corry,
        'floor': floor,
        'vaccency': "4",
        'memeber1': "",
        'memeber2': "",
        'memeber3': "",
        'memeber4': "",
        'vaccency': '4',
        'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
      };
}
