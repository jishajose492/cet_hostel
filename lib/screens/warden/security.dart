import 'package:flutter/material.dart';

class SecurityStaff {
  final String designation;
  final String name;
  final String phone;

  SecurityStaff(
      {required this.designation, required this.name, required this.phone});
}

class SecurityStaffPage extends StatelessWidget {
  final List<SecurityStaff> securityStaffList = [
    SecurityStaff(
        designation: 'Security Staff', name: 'Akhil S', phone: '9495829226'),
    SecurityStaff(
        designation: 'Security Staff',
        name: 'Hariprasad N',
        phone: '9605567720'),
    SecurityStaff(
        designation: 'Security Staff',
        name: 'Santhosh Kumar. S',
        phone: '9497771649'),
    SecurityStaff(
        designation: 'Security Staff', name: 'Hemanth S', phone: '9995337133'),
    SecurityStaff(
        designation: 'Security Staff', name: 'Sunil O', phone: '9207620710'),
    SecurityStaff(
        designation: 'Security Staff',
        name: 'Sajeeshkumar S',
        phone: '71508761681'),
    SecurityStaff(
        designation: 'Security Staff', name: 'Arun A R', phone: '7736846789'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Security Staff',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView.builder(
        itemCount: securityStaffList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Card(
              color: Color.fromARGB(255, 125, 196, 255),
              elevation: 4.0,
              child: ListTile(
                leading: Icon(Icons.security),
                title: Text(
                  securityStaffList[index].designation,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.0),
                    Text(
                      'Name: ${securityStaffList[index].name}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Phone: ${securityStaffList[index].phone}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 8.0),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
