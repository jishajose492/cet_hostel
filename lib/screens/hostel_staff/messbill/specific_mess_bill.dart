import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

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
  int _total = 0;
  Map<String, dynamic>? paymentIntent;
  @override
  void initState() {
    super.initState();
    // _calculateMessBill();
    _getArrayLength();
  }

  Future<void> _getArrayLength() async {
    final length = await getAttendanceCountByMonth(widget.roomid, widget.uid);
    // print(length);
    // setState(() {
    //   _totalAttendence = length ;
    //   _totalmesscharges = _totalAttendence * 120;
    //   _total = _totalRent + _totalMessWages + _totalmesscharges;
    // });
  }

  Future<Map<String, int>> getAttendanceCountByMonth(
      String roomId, String uid) async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('Rooms')
        .doc(roomId)
        .collection('attendence')
        .doc(uid)
        .get();

    final dataArray = docSnapshot.data()?['precents'] as List<dynamic>?;
    print("hhohoi");
    print(dataArray);

    // Create a map to store the attendance count for each month
    final attendanceCountByMonth = <String, int>{};

    if (dataArray != null) {
      for (var attendanceDate in dataArray) {
        // Extract the month and year from the attendance date
        final attendanceMonth = DateTime.parse(attendanceDate).month.toString();
        final attendanceYear = DateTime.parse(attendanceDate).year.toString();
        final monthYear = '$attendanceMonth-$attendanceYear';

        // Update the attendance count for the corresponding month
        if (attendanceCountByMonth.containsKey(monthYear)) {
          attendanceCountByMonth[monthYear] =
              attendanceCountByMonth[monthYear]! + 1;
        } else {
          attendanceCountByMonth[monthYear] = 1;
        }
      }
    }
    print(attendanceCountByMonth);
    return attendanceCountByMonth;
  }

  Future<void> _payMessBill() async {
    try {
      paymentIntent = await createPaymentIntent('$_total', 'INR');

      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent!['client_secret'],
                  // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92'),
                  // googlePay: const PaymentSheetGooglePay(testEnv: true,currencyCode: "US",merchantCountryCode: merchantCountryCode)
                  style: ThemeMode.dark,
                  merchantDisplayName: 'Adnan'))
          .then((value) {});

      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                          Text("Payment Successfull"),
                        ],
                      ),
                    ],
                  ),
                ));
        paymentIntent = null;
      }).onError((error, stackTrace) {
        print('Error is :---->$error$stackTrace');
      });
    } on StripeException catch (e) {
      print('Error is :--->$e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled"),
              ));
    } catch (e) {
      print('$e');
    }
  }

  // Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51N6DkOSHIWQ65VmROvdugOgAlaJCMQU8Ft3OwVl2B2c9pvvxv7KtOTRnUYwrZFymJdgxjfgJXl2kMgpt8JZCurGF00acXUs9mT',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      print('Payment Intent Body->>> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;
    return calculatedAmout.toString();
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
                  'TOTAL: $_total',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              SizedBox(height: 32.0),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    await _payMessBill();
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
