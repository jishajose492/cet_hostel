import 'package:cet_hostel/screens/hostel_staff/messbill/card_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class MessBillDetailsScreen extends StatefulWidget {
  final String uid;
  final String roomid;

  MessBillDetailsScreen({required this.uid, required this.roomid});

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
    // _calculateMessBill();
    _getArrayLength();
  }

  Future<void> _getArrayLength() async {
    final length = await getAttendanceLength(widget.roomid, widget.uid);
    setState(() {
      _totalAttendence = length;
      _totalmesscharges = _totalAttendence * 120;
    });
  }

  Future<int> getAttendanceLength(String roomId, String uid) async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Rooms')
        .doc(widget.roomid)
        .collection('attendence')
        .doc(widget.uid)
        .get();

    final dataArray = docSnapshot.data()?['precents'] as List<dynamic>?;
    return dataArray?.length ?? 0;
  }

  // Future<void> _payMessBill() async {
  //   try {
  //     final paymentMethod = await StripePayment.paymentRequestWithCardForm(
  //       CardFormPaymentRequest(),
  //     );

  //     final paymentIntent = await _createPaymentIntent(paymentMethod);

  //     await StripePayment.confirmPaymentIntent(
  //       PaymentIntent(
  //         clientSecret: paymentIntent['client_secret'],
  //         paymentMethodId: paymentMethod.id,
  //       ),
  //     );

  //     // Payment successful, update the UI or database accordingly
  //   } catch (e) {
  //     // Payment failed, handle the error
  //   }
  // }

  // Future<Map<String, dynamic>> _createPaymentIntent(
  //     PaymentMethod paymentMethod) async {
  //   final url = Uri.parse('https://your-server.com/create-payment-intent');
  //   final response = await http.post(url, body: {
  //     'amount': '1000', // replace with the actual amount
  //     'currency': 'usd',
  //     'payment_method': paymentMethod.id,
  //   });

  //   return jsonDecode(response.body);
  // }

  // void _calculateMessBill() async {
  //   FirebaseFirestore.instance.collection('Rooms').get().then((roomDocs) {
  //     roomDocs.docs.forEach((roomDoc) {
  //       final room = roomDoc.data();
  //       final roomId = room['roomid'];

  //       FirebaseFirestore.instance
  //           .collection('attendence')
  //           .doc('id')
  //           .get()
  //           .then((attendenceDoc) {
  //         print(attendenceDoc.data());
  //         if (attendenceDoc.exists) {
  //           final attendence = attendenceDoc.data();

  //           _totalAttendence = (attendence?['precents'] as List<dynamic>)
  //               .where((element) => element == true)
  //               .length;
  //           print("raees testing");
  //           print(_totalAttendence);

  //           int _totalmesscharges = _totalAttendence * 120;
  //         }
  //       });
  //     });
  //   });
  // }

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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => card_form(),
                      ),
                    );
                  },
                  // () async {
                  //   await _payMessBill();
                  // },
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
