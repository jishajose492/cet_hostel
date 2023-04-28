import 'package:cet_hostel/screens/search_menu/complaint/complaint_screen.dart';
import 'package:cet_hostel/screens/search_menu/emergency.dart';
import 'package:cet_hostel/screens/search_menu/add_events.dart';
import 'package:cet_hostel/screens/search_menu/events.dart';
import 'package:cet_hostel/screens/search_menu/feedback.dart';
import 'package:cet_hostel/screens/search_menu/menu/menu.dart';
import 'package:cet_hostel/screens/search_menu/room_search.dart';
import 'package:cet_hostel/screens/warden/staff/staff/add_staff_screen.dart';

import 'package:cet_hostel/screens/warden/staff/staff/staff_list_screen.dart';

import 'package:cet_hostel/screens/search_menu/staff_anothermethod.dart';
import 'package:cet_hostel/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class SearchBar extends StatefulWidget {
  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        //   title: Text('CET Hostel App'),
        //   // actions: <Widget>[
        //   //   IconButton(
        //   //     icon: Icon(Icons.notifications),
        //   //     onPressed: () {
        //   //       // TODO: Implement notifications functionality
        //   //     },
        //   //   ),
        //   //   IconButton(
        //   //     icon: Icon(Icons.person),
        //   //     onPressed: () {
        //   //       // TODO: Implement user profile functionality
        //   //     },
        //   //   ),
        //   // ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                _buildMenuItem(
                  context,
                  'Rooms',
                  FontAwesome5Solid.bed,
                  Colors.blue,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RoomListPage()),
                    );
                  },
                ),
                _buildMenuItem(
                  context,
                  'Mess Menu',
                  MaterialCommunityIcons.food_fork_drink,
                  Colors.green,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MenuSelectionPage()),
                    );
                  },
                ),
                _buildMenuItem(
                  context,
                  'Complaints',
                  Icons.report_problem,
                  Colors.yellow,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ComplaintPageView()),
                    );
                  },
                ),
                _buildMenuItem(
                  context,
                  'Feedback',
                  Icons.feedback,
                  Colors.orange,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InmateFeedbackPage()),
                    );
                  },
                ),
                _buildMenuItem(
                  context,
                  'Events',
                  Icons.event,
                  Colors.pink,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EventListScreen()),
                    );
                  },
                ),
                _buildMenuItem(
                  context,
                  'Emergency Contacts',
                  Icons.local_hospital,
                  Colors.red,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EmergencyContactsPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, IconData iconData,
      Color backgroundColor, final VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        elevation: 4.0,
        color: backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              iconData,
              size: 48.0,
              //color: Colors.blue,
              color: Colors.white,
              //color: Color.fromARGB(255, 8, 8, 8),
            ),
            SizedBox(height: 8.0),
            Text(
              title,
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
