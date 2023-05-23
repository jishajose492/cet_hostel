import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//  2023418
class My extends StatefulWidget {
  final String roomid;
  final bool col1;
  final bool col2;
  final bool col3;
  final bool col4;
  const My({
    Key? key,
    required this.roomid,
    required this.col1,
    required this.col2,
    required this.col3,
    required this.col4,
  }) : super(key: key);
  @override
  State<My> createState() => _MyState();
}

class _MyState extends State<My> {
  late Future<List<String>> _futureDocumentIds;
  List<String> documentIds = [];
  @override
  void initState() {
    super.initState();

    _futureDocumentIds = getDocumentIds(widget.roomid);
    // _isChecked1 = isValuePresentInArray(_futureDocumentIds[1]);
  }

  bool chk1 = false;
  bool chek2 = false;
  bool chek3 = false;
  bool chek4 = false;
  bool _isChecked1 = false;
  bool _isChecked2 = false;
  bool _isChecked3 = false;
  bool _isChecked4 = false;
  String _username1 = '';
  String _username2 = '';
  String _username3 = '';
  String _username4 = '';
  String _userid1 = '';
  String _userid2 = '';
  String _userid3 = '';
  String _userid4 = '';

  // Future<bool> isDataPresentInArray(String id) async {
  //   final CollectionReference collection = FirebaseFirestore.instance
  //       .collection('Rooms')
  //       .doc(widget.roomid)
  //       .collection("attendence")
  //       .doc(id)
  //       .collection('precents');

  //   final snapshot =
  //       await collection.where('precents', arrayContains: '2023423').get();

  //   return snapshot.docs.isNotEmpty;
  // }

  Future<bool> isPresentInAttendance(
    String attendanceId,
  ) async {
    DateTime currentDate = DateTime.now();
    String year = currentDate.year.toString();
    String month = currentDate.month.toString();
    String day = currentDate.day.toString();
    String data = year + month + day;
    final DocumentReference attendanceReference = FirebaseFirestore.instance
        .collection('Rooms')
        .doc(widget.roomid)
        .collection('attendence')
        .doc(attendanceId);

    final snapshot = await attendanceReference.get();

    if (!snapshot.exists) {
      throw Exception('Attendance document does not exist!');
    }

    final attendanceData = snapshot.data() as Map<String, dynamic>?;
    final precents = attendanceData?['precents'] as List<dynamic>?;

    if (precents == null) {
      throw Exception('Precents array not found in attendance document!');
    }

    return precents.contains(data);
  }

  bool isValuePresentInArray(String id) {
    bool isPresent = false;
    final CollectionReference attendanceRef = FirebaseFirestore.instance
        .collection('Rooms')
        .doc(widget.roomid)
        .collection('attendence');

    List<dynamic>? array = [];

    DateTime currentDate = DateTime.now();
    String year = currentDate.year.toString();
    String month = currentDate.month.toString();
    String day = currentDate.day.toString();
    attendanceRef.doc(id).get().then((doc) {
      if (doc.exists) {
        array = (doc.data() as Map<String, dynamic>)['precents'];
        if (array != null) {
          print(year + month + day);
          print("from " + id);
          print("returmred trueeeeee");
          isPresent = true;
          // return isPresent;
        } else {
          print("returmred false");
          isPresent = false;
          // return isPresent;
        }
      } else {
        print("returmred false");
        isPresent = false;
        // return isPresent;
      }
    });
    print("ast one");
    print(isPresent);
    return isPresent;
  }

  // Future<String> getUsernameFromId(String userId) async {
  //   DocumentSnapshot snapshot =
  //       await FirebaseFirestore.instance.collection('users').doc(userId).get();

  //   if (snapshot.exists) {
  //     String username = snapshot.get('username');
  //     return username;
  //   } else {
  //     return 'User not found';
  //   }
  // }

  // final String userId =
  //     'EnoyUVco5wYye2IfB2zQqKSgf382'; // Replace with your user ID

  Future<DocumentSnapshot<Map<String, dynamic>>> _fetchUserData(
      String uid) async {
    return await FirebaseFirestore.instance.collection('users').doc(uid).get();
  }

  // Future<String> _getUserInfo1(String userId) async {
  //   _userid1 = userId;
  //   String username1 = await getUsernameFromId(userId);
  //   _username1 = username1;

  //   return username1; // return the username as a Future<String>
  // }

  Future<List<String>> getDocumentIds(String roomId) async {
    List<String> documentIds = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Rooms')
        .doc(roomId)
        .collection("attendence")
        .get();
    snapshot.docs.forEach((doc) {
      documentIds.add(doc.id);
    });
    return documentIds;
  }

  Future<void> deleteValueFromExistingArray(
      String userId, String valueToDelete) async {
    try {
      final CollectionReference userdd = FirebaseFirestore.instance
          .collection('Rooms')
          .doc(widget.roomid)
          .collection("attendence");
      await userdd.doc(userId).update({
        'precents': FieldValue.arrayRemove([valueToDelete]),
      });
      print('Value deleted from existing array successfully');
    } catch (e) {
      print('Error deleting value from existing array: $e');
    }
  }

  Future<void> addValueToExistingArray(String userId, String newValue) async {
    try {
      final CollectionReference userdd = FirebaseFirestore.instance
          .collection('Rooms')
          .doc(widget.roomid)
          .collection("attendence");
      await userdd.doc(userId).update({
        'precents': FieldValue.arrayUnion([newValue]),
      });
      print('Value added to existing array successfully');
    } catch (e) {
      print('Error adding value to existing array: $e');
    }
  }

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Container Generator'),
        ),
        body: Column(
          children: [
            widget.col1
                ? FutureBuilder<List<String>>(
                    future: _futureDocumentIds,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<String>> snapshot) {
                      if (snapshot.hasData) {
                        _userid1 = snapshot.data![0];

                        // _getUserInfo1(snapshot.data![0]);
                        // print("b");
                        // print(b);

                        // print(snapshot.data![0]);
                        // print("snapshot.data![0]");
                        // print("_username1");
                        print(_username1);

                        return FutureBuilder<DocumentSnapshot>(
                          future: _fetchUserData(snapshot.data![0]),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final String username =
                                  snapshot.data!['username'];

                              // return Center(
                              //   child: Text('Username: $username'),
                              // );
                              return Card(
                                margin: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(16.0),
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              username,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          !chk1
                                              ? FutureBuilder<bool>(
                                                  future: isPresentInAttendance(
                                                      _userid1),
                                                  builder:
                                                      (BuildContext context,
                                                          AsyncSnapshot<bool>
                                                              snapshot) {
                                                    if (snapshot.hasData) {
                                                      snapshot.data!
                                                          ? _isChecked1 = true
                                                          : _isChecked1 = false;
                                                      chk1 = true;
                                                      return Checkbox(
                                                        value: snapshot.data!,
                                                        onChanged:
                                                            (bool? newValue) {
                                                          setState(() {
                                                            _isChecked1 =
                                                                !_isChecked1;
                                                            chk1 = true;
                                                          });
                                                        },
                                                      );
                                                    } else if (snapshot
                                                        .hasError) {
                                                      chk1 = true;
                                                      return Text(
                                                          'Error: ${snapshot.error}');
                                                      // chk1 = true;
                                                    } else {
                                                      return CircularProgressIndicator();
                                                    }
                                                  },
                                                )
                                              : Checkbox(
                                                  value: _isChecked1,
                                                  onChanged: (bool? value) {
                                                    setState(() {
                                                      print(
                                                          "from checkbox1 false");
                                                      _isChecked1 =
                                                          !_isChecked1;
                                                      print(value);
                                                      print("value");
                                                    });
                                                  },
                                                ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text('Error fetching user data'),
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  )
                : Container(),
            widget.col2
                ? FutureBuilder<List<String>>(
                    future: _futureDocumentIds,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<String>> snapshot) {
                      if (snapshot.hasData) {
                        _userid2 = snapshot.data![1];

                        // _getUserInfo1(snapshot.data![0]);
                        // print("b");
                        // print(b);

                        // print(snapshot.data![0]);
                        // print("snapshot.data![0]");
                        // print("_username1");
                        // print(_username1);

                        return FutureBuilder<DocumentSnapshot>(
                          future: _fetchUserData(snapshot.data![1]),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final String username =
                                  snapshot.data!['username'];
                              return Card(
                                margin: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(16.0),
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              username,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),

                                          !chek2
                                              ? FutureBuilder<bool>(
                                                  future: isPresentInAttendance(
                                                      _userid2),
                                                  builder:
                                                      (BuildContext context,
                                                          AsyncSnapshot<bool>
                                                              snapshot) {
                                                    if (snapshot.hasData) {
                                                      print("dta precemted");
                                                      print(_isChecked2);
                                                      print("dta precemted");
                                                      snapshot.data!
                                                          ? _isChecked2 = true
                                                          : _isChecked2 = false;
                                                      chk1 = true;
                                                      print(_isChecked2);
                                                      return Checkbox(
                                                        value: snapshot.data!,
                                                        onChanged:
                                                            (bool? newValue) {
                                                          setState(() {
                                                            _isChecked2 =
                                                                !_isChecked2;
                                                            chek2 = true;
                                                          });
                                                        },
                                                      );
                                                    } else if (snapshot
                                                        .hasError) {
                                                      chek2 = true;
                                                      return Text(
                                                          'Error: ${snapshot.error}');
                                                      // chk1 = true;
                                                    } else {
                                                      return CircularProgressIndicator();
                                                    }
                                                  },
                                                )
                                              : Checkbox(
                                                  value: _isChecked2,
                                                  onChanged: (bool? value) {
                                                    setState(() {
                                                      print(
                                                          "from checkbox1 false");
                                                      _isChecked2 =
                                                          !_isChecked2;
                                                      print(value);
                                                      print("value");
                                                    });
                                                  },
                                                ),
                                          // !chek2
                                          //     ? FutureBuilder<bool>(
                                          //         future: isPresentInAttendance(
                                          //             _userid2),
                                          //         builder:
                                          //             (BuildContext context,
                                          //                 AsyncSnapshot<bool>
                                          //                     snapshot) {
                                          //           if (snapshot.hasData) {
                                          //             print(
                                          //                 "from checkboxxxx2");
                                          //             snapshot.data!
                                          //                 ? _isChecked2 = true
                                          //                 : _isChecked2 = false;
                                          //             chek2 = true;
                                          //             return Checkbox(
                                          //                 value: snapshot.data!,
                                          //                 onChanged:
                                          //                     (bool? newValue) {
                                          //                   setState(() {
                                          //                     chek2 = true;
                                          //                     _isChecked2 =
                                          //                         !_isChecked2;
                                          //                   });
                                          //                 });
                                          //           } else if (snapshot
                                          //               .hasError) {
                                          //             return Text(
                                          //                 'Error: ${snapshot.error}');
                                          //             // chk1 = true;
                                          //           } else {
                                          //             return CircularProgressIndicator();
                                          //           }
                                          //         },
                                          //       )
                                          //     : Checkbox(
                                          //         value: _isChecked2,
                                          //         onChanged: (bool? value) {
                                          //           setState(() {
                                          //             _isChecked2 =
                                          //                 !_isChecked2;
                                          //           });
                                          //         },
                                          //       ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text('Error fetching user data'),
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  )
                : Container(),
            widget.col3
                ? FutureBuilder<List<String>>(
                    future: _futureDocumentIds,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<String>> snapshot) {
                      if (snapshot.hasData) {
                        _userid3 = snapshot.data![2];

                        // _getUserInfo1(snapshot.data![0]);
                        // print("b");
                        // print(b);

                        // print(snapshot.data![0]);
                        // print("snapshot.data![0]");
                        // print("_username1");
                        // print(_username1);

                        return FutureBuilder<DocumentSnapshot>(
                          future: _fetchUserData(snapshot.data![2]),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final String username =
                                  snapshot.data!['username'];
                              return Card(
                                margin: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(16.0),
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              username,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          !chek3
                                              ? FutureBuilder<bool>(
                                                  future: isPresentInAttendance(
                                                      _userid3),
                                                  builder:
                                                      (BuildContext context,
                                                          AsyncSnapshot<bool>
                                                              snapshot) {
                                                    if (snapshot.hasData) {
                                                      snapshot.data!
                                                          ? _isChecked3 = true
                                                          : _isChecked3 = false;
                                                      chek3 = true;
                                                      return Checkbox(
                                                          value: snapshot.data!,
                                                          onChanged:
                                                              (bool? newValue) {
                                                            setState(() {
                                                              _isChecked3 =
                                                                  !_isChecked3;
                                                            });
                                                          });
                                                    } else if (snapshot
                                                        .hasError) {
                                                      chek2 = true;
                                                      return Text(
                                                          'Error: ${snapshot.error}');
                                                      // chk1 = true;
                                                    } else {
                                                      chek2 = true;
                                                      return CircularProgressIndicator();
                                                    }
                                                  },
                                                )
                                              : Checkbox(
                                                  value: _isChecked3,
                                                  onChanged: (bool? value) {
                                                    setState(() {
                                                      _isChecked3 = value!;
                                                    });
                                                  },
                                                ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text('Error fetching user data'),
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  )
                : Container(),
            widget.col4
                ? FutureBuilder<List<String>>(
                    future: _futureDocumentIds,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<String>> snapshot) {
                      if (snapshot.hasData) {
                        _userid4 = snapshot.data![3];

                        // _getUserInfo1(snapshot.data![0]);
                        // print("b");
                        // print(b);

                        // print(snapshot.data![0]);
                        // print("snapshot.data![0]");
                        // print("_username1");
                        // print(_username1);

                        return FutureBuilder<DocumentSnapshot>(
                          future: _fetchUserData(snapshot.data![3]),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final String username =
                                  snapshot.data!['username'];
                              return Card(
                                margin: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(16.0),
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              username,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          !chek4
                                              ? FutureBuilder<bool>(
                                                  future: isPresentInAttendance(
                                                      _userid4),
                                                  builder:
                                                      (BuildContext context,
                                                          AsyncSnapshot<bool>
                                                              snapshot) {
                                                    if (snapshot.hasData) {
                                                      snapshot.data!
                                                          ? _isChecked4 = true
                                                          : _isChecked4 = false;
                                                      chek3 = true;
                                                      return Checkbox(
                                                          value: snapshot.data!,
                                                          onChanged:
                                                              (bool? newValue) {
                                                            setState(() {
                                                              _isChecked4 =
                                                                  !_isChecked4;
                                                            });
                                                          });
                                                    } else if (snapshot
                                                        .hasError) {
                                                      chek4 = true;
                                                      return Text(
                                                          'Error: ${snapshot.error}');
                                                      // chk1 = true;
                                                    } else {
                                                      chek4 = true;
                                                      return CircularProgressIndicator();
                                                    }
                                                  },
                                                )
                                              : Checkbox(
                                                  value: _isChecked4,
                                                  onChanged: (bool? value) {
                                                    setState(() {
                                                      _isChecked4 = value!;
                                                    });
                                                  },
                                                ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text('Error fetching user data'),
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  )
                : Container(),
            Card(
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: InkWell(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        DateTime currentDate = DateTime.now();
                        String year = currentDate.year.toString();
                        String month = currentDate.month.toString();
                        String day = currentDate.day.toString();

                        if (_isChecked1) {
                          print('Current date: $day/$month/$year');

                          addValueToExistingArray(_userid1, year + month + day);
                        } else {
                          deleteValueFromExistingArray(
                              _userid1, year + month + day);
                        }
                        if (_isChecked2) {
                          print('Current date: $day/$month/$year');

                          addValueToExistingArray(_userid2, year + month + day);
                        } else {
                          deleteValueFromExistingArray(
                              _userid2, year + month + day);
                        }
                        if (_isChecked3) {
                          print('Current date: $day/$month/$year');

                          addValueToExistingArray(_userid3, year + month + day);
                        } else {
                          deleteValueFromExistingArray(
                              _userid3, year + month + day);
                        }
                        if (_isChecked4) {
                          print('Current date: $day/$month/$year');

                          addValueToExistingArray(_userid4, year + month + day);
                        } else {
                          deleteValueFromExistingArray(
                              _userid4, year + month + day);
                        }
                      },
                      child: Container(
                          width: 300,
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: Center(
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
