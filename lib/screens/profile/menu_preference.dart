import 'package:flutter/material.dart';

class MenuPreferenceScreen extends StatefulWidget {
  const MenuPreferenceScreen({Key? key}) : super(key: key);

  @override
  _MenuPreferenceScreenState createState() => _MenuPreferenceScreenState();
}

class _MenuPreferenceScreenState extends State<MenuPreferenceScreen> {
  String? _foodPreference;
  String? _specialMenu;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        onPressed: () {
          // TODO: Save the user's menu preferences
          Navigator.pop(context);
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
