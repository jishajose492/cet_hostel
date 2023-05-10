import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessBillDetailsScreen extends StatefulWidget {
  final String uid;

  MessBillDetailsScreen({required this.uid});

  @override
  _MessBillDetailsScreenState createState() => _MessBillDetailsScreenState();
}

class _MessBillDetailsScreenState extends State<MessBillDetailsScreen> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  int _totalAttendence = 0;
  int _totalMessWages = 386;
  int _totalRent = 310;
  int _totalmesscharges = 0;

  @override
  void initState() {
    super.initState();
    _calculateMessBill();
  }

  void _calculateMessBill() async {
    FirebaseFirestore.instance.collection('Rooms').get().then((roomDocs) {
      roomDocs.docs.forEach((roomDoc) {
        final room = roomDoc.data();
        final roomId = room['roomid'];

        FirebaseFirestore.instance
            .collection('attendence')
            .doc('id')
            .get()
            .then((attendenceDoc) {
          print(attendenceDoc.data());
          if (attendenceDoc.exists) {
            final attendence = attendenceDoc.data();

            int _totalAttendence = (attendence?['precents'] as List<dynamic>)
                .where((element) => element == true)
                .length;
            print(_totalAttendence);
            int _totalmesscharges = _totalAttendence * 120;
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          'Mess Bill Details',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _db.collection('users').doc(widget.uid).snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 16.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Name: ${data?['username']}',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Attendance: $_totalAttendence',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              SizedBox(height: 16.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Mess Charge per day: 120',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              SizedBox(height: 16.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Mess Charges: $_totalmesscharges',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              SizedBox(height: 16.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Wages & coolies: $_totalMessWages',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              SizedBox(height: 16.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Room Rent: $_totalRent',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              SizedBox(height: 16.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'TOTAL: ${_totalRent + _totalMessWages + _totalmesscharges}',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              SizedBox(height: 32.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Code to pay the mess bill
                  },
                  child: Text('Pay Mess Bill'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
