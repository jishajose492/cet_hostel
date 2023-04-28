import 'package:flutter/material.dart';

class WardenPage1 extends StatefulWidget {
  @override
  _WardenPage1State createState() => _WardenPage1State();
}

class _WardenPage1State extends State<WardenPage1> {
  List<Map<String, dynamic>> _staffList = [
    {'name': 'John Doe', 'position': 'Cook', 'salary': '2000'},
    {'name': 'Jane Smith', 'position': 'Cleaner', 'salary': '1500'},
    {'name': 'Peter Parker', 'position': 'Security Guard', 'salary': '1800'}
  ];

  TextEditingController _nameController = TextEditingController();
  TextEditingController _positionController = TextEditingController();
  TextEditingController _salaryController = TextEditingController();

  _addStaff() {
    setState(() {
      _staffList.add({
        'name': _nameController.text,
        'position': _positionController.text,
        'salary': _salaryController.text,
      });
      _nameController.clear();
      _positionController.clear();
      _salaryController.clear();
    });
  }

  _deleteStaff(int index) {
    setState(() {
      _staffList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Warden Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
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
                    controller: _positionController,
                    decoration: InputDecoration(
                      labelText: 'Position',
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _salaryController,
                    decoration: InputDecoration(
                      labelText: 'Salary',
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    child: Text('Add Staff'),
                    onPressed: _addStaff,
                  ),
                ],
              ),
            ),
            Divider(),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _staffList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_staffList[index]['name']),
                  subtitle: Text(_staffList[index]['position']),
                  trailing: Text('${_staffList[index]['salary']} \$'),
                  onTap: () => _deleteStaff(index),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
