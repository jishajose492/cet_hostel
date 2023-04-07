import 'package:cet_hostel/screens/search_menu/room_search.dart';
import 'package:cet_hostel/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

String rooms = roomsearch().toString();

class SearchBar extends StatefulWidget {
  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  // @override
  // Widget build1(BuildContext context) {
  //   return MaterialApp(

  //     routes: {
  //       '/rooms': (context) => roomsearch(),
  //     },
  //   );
  // }

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
                    context, 'Rooms', FontAwesome5Solid.bed, '/rooms'),
                _buildMenuItem(context, 'Mess Menu',
                    MaterialCommunityIcons.food_fork_drink, '/menu'),
                _buildMenuItem(
                    context, 'Complaints', Icons.report_problem, '/complaints'),
                _buildMenuItem(
                    context, 'Feedback', Icons.feedback, '/feedback'),
                _buildMenuItem(context, 'Events', Icons.event, '/events'),
                _buildMenuItem(context, 'Emergency Contacts',
                    Icons.local_hospital, '/emergency'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
      BuildContext context, String title, IconData iconData, String routeName) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Card(
        elevation: 4.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              iconData,
              size: 48.0,
              color: Color.fromARGB(255, 8, 8, 8),
            ),
            SizedBox(height: 8.0),
            Text(
              title,
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
