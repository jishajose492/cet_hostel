import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class StaffDetailsScreen extends StatefulWidget {
  @override
  _StaffDetailsScreenState createState() => _StaffDetailsScreenState();
}

class _StaffDetailsScreenState extends State<StaffDetailsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  String id = Uuid().v4();
  void _addStaffDetails() {
    String name = _nameController.text.trim();
    String role = _roleController.text.trim();
    String contact = _contactController.text.trim();

    if (name.isEmpty || role.isEmpty || contact.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('All fields are required.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      FirebaseFirestore.instance
          .collection('hostel_staff')
          .doc(id)
          .set({
            'id': id,
            'name': name,
            'role': role,
            'contact': contact,
          })
          .then((value) => {
                _nameController.clear(),
                _roleController.clear(),
                _contactController.clear(),
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Success'),
                    content: Text('Staff details added.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('OK'),
                      ),
                    ],
                  ),
                ),
              })
          .catchError((error) => {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Error'),
                    content: Text('Failed to add staff details.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('OK'),
                      ),
                    ],
                  ),
                ),
              });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hostel Staff Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _roleController,
              decoration: InputDecoration(
                labelText: 'Role',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _contactController,
              decoration: InputDecoration(
                labelText: 'Contact',
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _addStaffDetails,
              child: Text('Add Staff Details'),
            ),
          ],
        ),
      ),
    );
  }
}
