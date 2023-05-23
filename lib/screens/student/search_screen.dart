import 'package:cet_hostel/screens/student/search_menu/complaint/complaint_screen.dart';
import 'package:cet_hostel/screens/student/search_menu/emergency.dart';
import 'package:cet_hostel/screens/student/search_menu/add_events.dart';
import 'package:cet_hostel/screens/student/search_menu/events.dart';
import 'package:cet_hostel/screens/student/search_menu/feedback.dart';
import 'package:cet_hostel/screens/student/search_menu/menu/menu.dart';
//import 'package:cet_hostel/screens/student/search_menu/room_search.dart';
import 'package:cet_hostel/screens/warden/staff/staff/add_staff_screen.dart';
import 'package:cet_hostel/screens/student/search_menu/viewAllRoom.dart';
import 'package:cet_hostel/screens/warden/staff/staff/staff_list_screen.dart';

import 'package:cet_hostel/screens/student/search_menu/staff_anothermethod.dart';
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
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //     title: Text('CET Hostel App'),
      //     // actions: <Widget>[
      //     //   IconButton(
      //     //     icon: Icon(Icons.notifications),
      //     //     onPressed: () {
      //     //       // TODO: Implement notifications functionality
      //     //     },
      //     //   ),
      //     //   IconButton(
      //     //     icon: Icon(Icons.person),
      //     //     onPressed: () {
      //     //       // TODO: Implement user profile functionality
      //     //     },
      //     //   ),
      //     // ],
      // ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildMenuItem(
                    context,
                    'Rooms',
                    FontAwesome5Solid.bed,
                    Colors.blue,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ViewAllRooms()),
                      );
                    },
                  ),
                  SizedBox(
                    width: 10,
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
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildMenuItem(
                    context,
                    'Complaints',
                    Icons.report_problem,
                    Colors.pink,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ComplaintPageView()),
                      );
                    },
                  ),
                  SizedBox(
                    width: 10,
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
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildMenuItem(
                    context,
                    'Events',
                    Icons.event,
                    Colors.teal,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EventListScreen()),
                      );
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  _buildMenuItem(
                    context,
                    'Emergency Contacts',
                    Icons.local_hospital,
                    Colors.brown,
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
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, IconData icon,
      Color color, final VoidCallback onPressed) {
    return Expanded(
      child: InkWell(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: color,
              ),
              SizedBox(height: 20),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
