import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MyDropdown extends StatefulWidget {
  @override
  _MyDropdownState createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  void updateroomidinusers(String newValue) {
    // Reference to the document in Firestore
    final DocumentReference documentReference = FirebaseFirestore.instance
        .collection("usersnew")
        .doc(FirebaseAuth.instance.currentUser!.uid);

    // Update the specified field in Firestore
    documentReference.update({'roomid': newValue}).then((_) {
      print('Field updated successfully!');
    }).catchError((error) {
      print('Failed to update field: $error');
    });
  }

  void updateuserstatus() {
    // Reference to the document in Firestore
    final DocumentReference documentReference = FirebaseFirestore.instance
        .collection("usersnew")
        .doc(FirebaseAuth.instance.currentUser!.uid);

    // Update the specified field in Firestore
    documentReference.update({'status': "roomalotted"}).then((_) {
      print('Field updated successfully!');
    }).catchError((error) {
      print('Failed to update field: $error');
    });
  }

  void updateUserIdInRooms(String selectedRoom) {
    final DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Rooms").doc(selectedRoom);

    documentReference.get().then((DocumentSnapshot snapshot) {
      // Check if the document exists and meets the specified criteria
      if (snapshot.exists &&
          snapshot.data() != null &&
          snapshot.get('memeber1') == '') {
        // Update the specified field in Firestore
        documentReference.update(
            {'memeber1': FirebaseAuth.instance.currentUser!.uid}).then((_) {
          print('Field updated successfully!');
        }).catchError((error) {
          print('Failed to update field: $error');
        });
        documentReference.update({'vaccency': '3'}).then((_) {
          print('vaccency updated successfully!');
        }).catchError((error) {
          print('vaccency  update error: $error');
        });
      } else if (snapshot.exists &&
          snapshot.data() != null &&
          snapshot.get('memeber2') == '') {
        // Update the specified field in Firestore
        documentReference.update(
            {'memeber2': FirebaseAuth.instance.currentUser!.uid}).then((_) {
          print('Field updated successfully!');
        }).catchError((error) {
          print('Failed to update field: $error');
        });
        documentReference.update({'vaccency': '2'}).then((_) {
          print('vaccency updated successfully!');
        }).catchError((error) {
          print('vaccency  update error: $error');
        });
      } else if (snapshot.exists &&
          snapshot.data() != null &&
          snapshot.get('memeber3') == '') {
        // Update the specified field in Firestore
        documentReference.update(
            {'memeber3': FirebaseAuth.instance.currentUser!.uid}).then((_) {
          print('Field updated successfully!');
        }).catchError((error) {
          print('Failed to update field: $error');
        });
        documentReference.update({'vaccency': '1'}).then((_) {
          print('vaccency updated successfully!');
        }).catchError((error) {
          print('vaccency  update error: $error');
        });
      } else if (snapshot.exists &&
          snapshot.data() != null &&
          snapshot.get('memeber4') == '') {
        // Update the specified field in Firestore
        documentReference.update(
            {'memeber4': FirebaseAuth.instance.currentUser!.uid}).then((_) {
          print('Field updated successfully!');
        }).catchError((error) {
          print('Failed to update field: $error');
        });
        documentReference.update({'vaccency': '0'}).then((_) {
          print('vaccency updated successfully!');
        }).catchError((error) {
          print('vaccency  update error: $error');
        });
      } else {
        print('Document does not meet the criteria');
      }
    }).catchError((error) {
      print('Failed to fetch document: $error');
    });
  }

  String _selectedItem = "";
  List<String> _dropdownItems = [];

  @override
  void initState() {
    super.initState();
    _getDropdownItems();
  }

  Future<void> _getDropdownItems() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('Rooms')
        .where('vaccency', isNotEqualTo: '0')
        .get();
    final List<String> items =
        snapshot.docs.map((doc) => doc.data()['roomid'] as String).toList();
    setState(() {
      _dropdownItems = items;
      _selectedItem = _dropdownItems[0]; // set initial value
    });
  }

  List<String> _items = [];
  Future<void> _saveItemsToFirestore() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('roomRequests')
        .doc(_selectedItem)
        .get();
    if (!docSnapshot.exists) {
      print("exist");
      await FirebaseFirestore.instance
          .collection('roomRequests')
          .doc(_selectedItem)
          .set({
        // 'requests': [],
        'roomid': _selectedItem,
      });
      // await FirebaseFirestore.instance
      //     .collection('roomRequests')
      //     .doc(_selectedItem)
      //     .collection('requestes')
      //     .doc(
      //       "Request for" + _selectedItem,
      //     )
      //     // DateTime.now().millisecondsSinceEpoch.toString()
      //     .set({
      //   'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
      //   'requests': "",
      // });
    }
  }

  final List<String> imageUrls = [
    'assets/images/img1.jpg',
    'assets/images/h1.jpg',
    'assets/images/h3.jpg',
    'assets/images/h2.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final dropdownString = _dropdownItems.join(', ');
    return Material(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 100),
            Container(
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 20 / 10,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ),
                items: imageUrls.map((imageUrl) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 2),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Stack(
                            children: [
                              Image.asset(
                                imageUrl,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.5),
                                      Colors.black.withOpacity(0.8),
                                    ],
                                    stops: [0.0, 0.6, 1.0],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 100),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Select available room',
                  border: OutlineInputBorder(),
                ),
                value: _selectedItem,
                onChanged: (value) {
                  setState(() {
                    _selectedItem = value!;
                    print(_selectedItem);
                  });
                },
                items: _dropdownItems.map((item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: () async {
                  print(_selectedItem);
                  // updateroomidinusers(_selectedItem);
                  // updateUserIdInRooms(_selectedItem);
                  updateuserstatus();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => Container(
                              child: Text("Hi"),
                            )
                        // builder: (context) => const mainhomedecition(
                        //       b: false,
                        //     ),
                        ),
                  );
                  // _saveItemsToFirestore();
                  // _items.add(_selectedItem);
                  // await FirebaseFirestore.instance
                  //     .collection('roomRequests')
                  //     .doc(_selectedItem)
                  //     .set({
                  //   'roomid': _selectedItem,
                  //   'requests`':

                  // });
                  // Scaffold.of(context).showSnackBar(
                  //   SnackBar(content: Text('Data saved')),
                  // );
                  // await FirebaseFirestore.instance
                  //     .collection('roomRequests')
                  //     .doc(_selectedItem)
                  //     .collection('requestes')
                  //     .doc(
                  //       FirebaseAuth.instance.currentUser!.uid,
                  //     )
                  //     .set({
                  //   'timestamp':
                  //       DateTime.now().millisecondsSinceEpoch.toString(),
                  //   'requests': FirebaseAuth.instance.currentUser!.uid,
                  // });

                  // FirebaseFirestore.instance
                  //     .collection('roomRequests')
                  //     .doc(_selectedItem)
                  //     .collection('requestes')
                  //     .doc(
                  //       FirebaseAuth.instance.currentUser!.uid,
                  //     )
                  //     .update({
                  //   'timestamp':
                  //       DateTime.now().millisecondsSinceEpoch.toString(),
                  //   'requests': FirebaseAuth.instance.currentUser!.uid
                  // });
                },
                child: Text("Confirm")),
          ],
        ),
      ),
    );
  }
}
