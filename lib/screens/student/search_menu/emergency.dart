// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// class EmergencyContactsPage extends StatefulWidget {
//   @override
//   State<EmergencyContactsPage> createState() => _EmergencyContactsPageState();
// }

// class _EmergencyContactsPageState extends State<EmergencyContactsPage> {
//   final List<Map<String, dynamic>> emergencyContacts = [
//     {
//       'designation': 'Warden ',
//       'name': 'Dr.Sumesh Divakaran',
//       'phone': '9497321481'
//     },
//     {
//       'designation': 'Asst.Warden ',
//       'name': 'Dr.Girija K',
//       'phone': '9496178255'
//     },
//     {
//       'designation': 'Asst.Warden ',
//       'name': 'Prof.Smitha M V',
//       'phone': '9746964833'
//     },
//     {
//       'designation': 'Sergeant ',
//       'name': 'Shri.Saji Kumar K',
//       'phone': '9149572284'
//     },
//     {'designation': 'Matron', 'name': 'Smt.Sindhu K V', 'phone': '9048315856'},
//     {
//       'designation': 'Matron ',
//       'name': 'Smt.Arya Sukumar',
//       'phone': '9497778583'
//     },
//     {'designation': 'Matron ', 'name': 'Smt.Shaja L', 'phone': '9778173794'},
//     {
//       'designation': 'Sick Room Attender ',
//       'name': 'Smt.Lijisha V R',
//       'phone': '9895039306'
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         iconTheme: IconThemeData(color: Colors.black),
//         title: Text(
//           "Emergency Contacts",
//           style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
//         ),
//       ),
//       body: SizedBox(
//         child: ListView.builder(
//           itemCount: emergencyContacts.length,
//           itemBuilder: (BuildContext context, int index) {
//             return InkWell(
//               onTap: () async {
//                 var phoneNumber = 'tel:+' + emergencyContacts[index]['phone'];
//                 // 'tel:+1234567890'; // replace with the actual phone number
//                 if (await canLaunch(phoneNumber)) {
//                   await launch(phoneNumber);
//                 } else {
//                   throw 'Could not launch $phoneNumber';
//                 }
//               },
//               child: Container(
//                 // margin: EdgeInsets.only(top: 20.0),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 20.0, vertical: 10.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15.0),
//                       color: Colors.white,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           spreadRadius: 2,
//                           blurRadius: 5,
//                           offset: Offset(0, 3),
//                         ),
//                       ],
//                     ),
//                     child: ListTile(
//                       leading: Icon(
//                         Icons.phone,
//                         color: Colors.blue,
//                         size: 40.0,
//                       ),
//                       title: Text(
//                         emergencyContacts[index]['designation'],
//                         style: TextStyle(
//                           fontSize: 20.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Text(
//                             emergencyContacts[index]['name'],
//                             style: TextStyle(
//                               fontWeight: FontWeight.normal,
//                               fontSize: 18,
//                               //color: Color.fromARGB(255, 0, 0, 0)
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Text(
//                             emergencyContacts[index]['phone'],
//                             style: TextStyle(
//                                 fontWeight: FontWeight.normal,
//                                 fontSize: 15,
//                                 color: Color.fromARGB(255, 0, 0, 0)),
//                           ),
//                           SizedBox(
//                             height: 15,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyContactsPage extends StatefulWidget {
  @override
  State<EmergencyContactsPage> createState() => _EmergencyContactsPageState();
}

class _EmergencyContactsPageState extends State<EmergencyContactsPage> {
  final List<Map<String, dynamic>> emergencyContacts = [
    {
      'designation': 'Warden ',
      'name': 'Dr.Sumesh Divakaran',
      'phone': '9497321481'
    },
    {
      'designation': 'Asst.Warden ',
      'name': 'Dr.Girija K',
      'phone': '9496178255'
    },
    {
      'designation': 'Asst.Warden ',
      'name': 'Prof.Smitha M V',
      'phone': '9746964833'
    },
    {
      'designation': 'Sergeant ',
      'name': 'Shri.Saji Kumar K',
      'phone': '9149572284'
    },
    {'designation': 'Matron', 'name': 'Smt.Sindhu K V', 'phone': '9048315856'},
    {
      'designation': 'Matron ',
      'name': 'Smt.Arya Sukumar',
      'phone': '9497778583'
    },
    {'designation': 'Matron ', 'name': 'Smt.Shaja L', 'phone': '9778173794'},
    {
      'designation': 'Sick Room Attender ',
      'name': 'Smt.Lijisha V R',
      'phone': '9895039306'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Emergency Contacts",
          style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
        ),
      ),
      body: SizedBox(
        child: ListView.builder(
          itemCount: emergencyContacts.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.phone,
                      color: Colors.blue,
                      size: 40.0,
                    ),
                    title: Text(
                      emergencyContacts[index]['designation'],
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          emergencyContacts[index]['name'],
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          emergencyContacts[index]['phone'],
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                    onTap: () async {
                      var phoneNumber =
                          'tel:+' + emergencyContacts[index]['phone'];
                      if (await canLaunch(phoneNumber)) {
                        await launch(phoneNumber);
                      } else {
                        throw 'Could not launch $phoneNumber';
                      }
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
