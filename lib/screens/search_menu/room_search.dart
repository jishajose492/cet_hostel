import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Room {
  final String roomnumber;
  //final String roomtype;
  //final bool isavailable;
  final num numberofbeds;

  Room({
    required this.roomnumber,
    //required this.roomtype,
    //required this.isavailable,
    required this.numberofbeds,
  });
}

class RoomListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Center(
          child: Text(
            "Room List",
            style:
                TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
            // style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        //title: Text('Room List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('rooms').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              List<Room> rooms =
                  snapshot.data!.docs.map((DocumentSnapshot document) {
                return Room(
                  roomnumber:
                      (document.data() as Map<String, dynamic>)['roomnumber'] ??
                          '',
                  //roomtype:
                  // (document.data() as Map<String, dynamic>)['roomtype'] ??
                  // '',
                  numberofbeds: (document.data()
                          as Map<String, dynamic>)['numberofbeds'] ??
                      '',
                  //isavailable: (document.data()
                  //as Map<String, dynamic>)['isavailable'] ??
                  //'',
                );
              }).toList();

              return ListView.builder(
                itemCount: rooms.length,
                itemBuilder: (BuildContext context, int index) {
                  Room room = rooms[index];
                  return ListTile(
                    title: Text(
                      'Room ${room.roomnumber}',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 20,
                          color: Color.fromARGB(255, 0, 0, 0)),
                    ),

                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'No of inmates filled: ${room.numberofbeds}',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // Text(
                        //   ' Room Capacity:${room.roomtype}',
                        //   style: TextStyle(
                        //       fontWeight: FontWeight.normal,
                        //       fontSize: 15,
                        //       color: Color.fromARGB(255, 0, 0, 0)),
                        // ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                    // Text(
                    //   'No of inmates filled: ${room.numberofbeds}',

                    // ),
                    trailing: (room.numberofbeds < 4)
                        ? Icon(
                            Icons.check_circle,
                            size: 35,
                            color: Colors.green,
                          )
                        : Icon(
                            Icons.cancel,
                            size: 35,
                            color: Colors.red,
                          ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
