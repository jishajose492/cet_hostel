import 'package:cet_hostel/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MenuPreferenceScreen extends StatefulWidget {
  const MenuPreferenceScreen({Key? key}) : super(key: key);

  @override
  _MenuPreferenceScreenState createState() => _MenuPreferenceScreenState();
}

class _MenuPreferenceScreenState extends State<MenuPreferenceScreen> {
  String? _foodPreference;
  String? _specialMenu;

  final _auth = FirebaseAuth.instance;

  final _firestore = FirebaseFirestore.instance;

  Future<void> _saveMenuPreferences() async {
    final user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).set({
        'foodPreference': _foodPreference,
        'specialMenu': _specialMenu,
      }, SetOptions(merge: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        //backgroundColor: Colors.white,
        // title: Text(
        //   "Menu Preference",
        //   style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
        //   style: Theme.of(context).textTheme.headlineSmall,
        // ),

        title: Text('Menu Preference'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select your food preference',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Radio<String>(
                  value: 'veg',
                  groupValue: _foodPreference,
                  onChanged: (value) {
                    setState(() {
                      _foodPreference = value;
                    });
                  },
                ),
                Text('Vegetarian'),
              ],
            ),
            Row(
              children: [
                Radio<String>(
                  value: 'non-veg',
                  groupValue: _foodPreference,
                  onChanged: (value) {
                    setState(() {
                      _foodPreference = value;
                    });
                  },
                ),
                Text('Non-Vegetarian'),
              ],
            ),
            Row(
              children: [
                Radio<String>(
                  value: 'veg+fish',
                  groupValue: _foodPreference,
                  onChanged: (value) {
                    setState(() {
                      _foodPreference = value;
                    });
                  },
                ),
                Text('Vegetarian + Fish'),
              ],
            ),
            Row(
              children: [
                Radio<String>(
                  value: 'veg+egg',
                  groupValue: _foodPreference,
                  onChanged: (value) {
                    setState(() {
                      _foodPreference = value;
                    });
                  },
                ),
                Text('Vegetarian + Egg'),
              ],
            ),
            Row(
              children: [
                Radio<String>(
                  value: 'veg+fish+egg',
                  groupValue: _foodPreference,
                  onChanged: (value) {
                    setState(() {
                      _foodPreference = value;
                    });
                  },
                ),
                Text('Vegetarian + Fish + Egg '),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Any special menu requirements?',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter your special menu requirements',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _specialMenu = value;
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _saveMenuPreferences();
          showSnackBar("Submitted Successfully", context);
          Navigator.pop(context);
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
