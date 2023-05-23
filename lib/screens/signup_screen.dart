import 'dart:typed_data';

import 'package:cet_hostel/resources/auth_methods.dart';
import 'package:cet_hostel/screens/login_screen.dart';

import 'package:cet_hostel/utils/colors.dart';
import 'package:cet_hostel/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';

import '../widgets/text_field_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String selectedDistrict = 'Thiruvananthapuram';
  String selectedDpl = 'APL';
  List<String> pl = ['APL', 'BPL'];
  List<String> districts = [
    'Thiruvananthapuram',
    'Kollam',
    'Pathanamthitta',
    'Alappuzha',
    'Kottayam',
    'Idukki',
    'Ernakulam',
    'Thrissur',
    'Palakkad',
    'Malappuram',
    'Kozhikode',
    'Wayanad',
    'Kannur',
    'Kasaragod',
  ];

  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _usernamecontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();

  final TextEditingController _incomecontroller = TextEditingController();
  Uint8List? _image;
  bool _isloading = false;

  @override
  void dispose() {
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _usernamecontroller.dispose();
    _phonecontroller.dispose();

    _incomecontroller.dispose();
  }

  void selectimage() async {
    Uint8List im = await pickimage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void SignUpUser() async {
    setState(() {
      _isloading = true;
    });
    if (_emailcontroller.text.isEmpty ||
        _passwordcontroller.text.isEmpty ||
        _image!.isEmpty ||
        _incomecontroller.text.isEmpty ||
        _emailcontroller.text.isEmpty ||
        _phonecontroller.text.isEmpty) {
      showSnackBar("Some fields are missing", context);
      setState(() {
        _isloading = false;
      });
    } else {
      double i;
      double d;
      if (int.parse(_incomecontroller.text) >= 10000000) {
        i = 6;
      } else if (int.parse(_incomecontroller.text) >= 3600000) {
        i = 12;
      } else if (int.parse(_incomecontroller.text) >= 2400000) {
        i = 18;
      } else if (int.parse(_incomecontroller.text) >= 1800000) {
        i = 24;
      } else if (int.parse(_incomecontroller.text) >= 1200000) {
        i = 30;
      } else if (int.parse(_incomecontroller.text) >= 900000) {
        i = 36;
      } else if (int.parse(_incomecontroller.text) >= 600000) {
        i = 42;
      } else if (int.parse(_incomecontroller.text) >= 400000) {
        i = 48;
      } else if (int.parse(_incomecontroller.text) >= 300000) {
        i = 54;
      } else if (int.parse(_incomecontroller.text) >= 200000) {
        i = 60;
      } else if (int.parse(_incomecontroller.text) >= 100000) {
        i = 66;
      } else {
        i = 75;
      }
      switch (selectedDistrict) {
        case 'Thiruvananthapuram':
          d = 25 / 14;
          break;
        case 'Kollam':
          d = 2 * 25 / 14;
          break;
        case 'Pathanamthitta':
          d = 3 * 25 / 14;
          break;
        case 'Alappuzha':
          d = 4 * 25 / 14;
          break;
        case 'Kottayam':
          d = 5 * 25 / 14;
          break;
        case 'Idukki':
          d = 6 * 25 / 14;
          break;
        case 'Ernakulam':
          d = 7 * 25 / 14;
          break;
        case 'Thrissur':
          d = 8 * 25 / 14;
          break;
        case 'Palakkad':
          d = 9 * 25 / 14;
          break;
        case 'Malappuram':
          d = 10 * 25 / 14;
          break;
        case 'Kozhikode':
          d = 11 * 25 / 14;
          break;
        case 'Wayanad':
          d = 12 * 25 / 14;
          break;
        case 'Kannur':
          d = 13 * 25 / 14;
          break;
        case 'Kasaragod':
          d = 14 * 25 / 14;
          break;
        default:
          d = 0; // Default value if the district is not found
      }
      String dd = (d + i).toString();
      print(dd);
      String res = await AuthMethods().SignUpUser(
        email: _emailcontroller.text,
        password: _passwordcontroller.text,
        username: _usernamecontroller.text,
        phone: _phonecontroller.text,
        file: _image!,
        district: selectedDistrict,
        income: _incomecontroller.text,
        totel: dd,
      );
      setState(() {
        _isloading = false;
      });
      if (res != 'Success') {
        showSnackBar(res, context);
      } else {
        print("no problem++++++++++++++++++++++++++++++++++++++=");
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => Container(
                      child: ElevatedButton(
                    onPressed: () async {
                      try {
                        await FirebaseAuth.instance.signOut();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginScreen()));

                        // Perform any additional tasks after logout
                        // For example, navigate to the login screen
                      } catch (e) {
                        print('Error occurred during logout: $e');
                      }
                    },
                    child: Text('Logout'),
                  ))),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 84,
              ),
              // image
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 84,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 84,
                          backgroundImage: AssetImage("assets/images/pro1.jpg"),
                        ),
                  Positioned(
                    bottom: -10,
                    left: 90,
                    child: IconButton(
                      onPressed: selectimage,
                      icon: const Icon(
                        Icons.add_a_photo,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 46,
              ),
              // ignore: prefer_const_constructors
              Text(
                "College of Engineering Trivandrum",
                style: TextStyle(
                  fontSize: 36,
                  height: h * 0.000001,
                  fontFamily: 'Cookie-Regular',
                ),
              ),
              const SizedBox(
                height: 46,
              ),
              //textfield for username
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      spreadRadius: 7,
                      offset: Offset(1, 1),
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ],
                ),
                child: Column(children: [
                  TextFieldInput(
                    hinttext: ' Enter username',
                    textInputType: TextInputType.text,
                    textEditingController: _usernamecontroller,
                  )
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              //textfield for phoneno
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      spreadRadius: 7,
                      offset: Offset(1, 1),
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ],
                ),
                child: Column(children: [
                  TextFieldInput(
                    hinttext: ' Enter phoneno',
                    textInputType: TextInputType.phone,
                    textEditingController: _phonecontroller,
                  )
                ]),
              ),
              SizedBox(
                height: 20,
              ),

              //textfield for email

              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      spreadRadius: 7,
                      offset: Offset(1, 1),
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ],
                ),
                child: Column(children: [
                  TextFieldInput(
                    hinttext: ' Enter email',
                    textInputType: TextInputType.emailAddress,
                    textEditingController: _emailcontroller,
                  )
                ]),
              ),

              SizedBox(
                height: 20,
              ),

              //textfield for phoneno

              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      spreadRadius: 7,
                      offset: Offset(1, 1),
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ],
                ),
                child: Column(children: [
                  TextFieldInput(
                    hinttext: ' Enter income',
                    textInputType: TextInputType.phone,
                    textEditingController: _incomecontroller,
                  )
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                margin: EdgeInsets.symmetric(vertical: 0, horizontal: 25),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 246, 248,
                      248), // Set the desired background color here
                  border: Border.all(color: Color.fromARGB(255, 255, 255, 255)),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Text(
                      '  District:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 30),
                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedDistrict,
                        hint: Text(
                          'Select District',
                          style: TextStyle(color: Colors.grey),
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedDistrict = newValue!;
                          });
                        },
                        items: districts
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        style: TextStyle(fontSize: 16, color: Colors.black),
                        icon: Icon(Icons.arrow_drop_down),
                        isExpanded: false,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              //textfield for password
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      spreadRadius: 7,
                      offset: Offset(1, 1),
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ],
                ),
                child: Column(children: [
                  TextFieldInput(
                    hinttext: ' Enter password',
                    textInputType: TextInputType.text,
                    textEditingController: _passwordcontroller,
                    isPass: true,
                  )
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              // Row(
              //   children: [
              //     Expanded(
              //       child: Container(),
              //     ),
              //     Text(
              //       "Forgot your Password?  ",
              //       style: TextStyle(fontSize: 15, color: Colors.black),
              //     ),
              //   ],
              // ),
              SizedBox(
                height: 26,
              ),
              //button

              Container(
                width: w * 0.5,
                height: h * 0.08,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/images/grey2.jpg",
                      ),
                      fit: BoxFit.cover),
                ),
                child: Center(
                  child: InkWell(
                    onTap: SignUpUser,
                    child: _isloading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : const Text(
                            "Sign up",
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                  ),
                ),
              ),
              SizedBox(
                height: w * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text('Already have an account? '),
                  ),
                  GestureDetector(
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                    },
                  )
                ],
              ),
              // child: const Text('Log in'),
              // width: double.infinity,
              // alignment: Alignment.center,
              // padding: const EdgeInsets.symmetric(vertical: 12),
              // decoration: const ShapeDecoration(
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.all(
              //       Radius.circular(
              //         4,
              //       ),
              //     ),
              //   ),
              //   color: gre
              // ),

              //transition to signup
            ],
          ),
        ),
      ),
    );
  }
}

// // import 'dart:typed_data';

// // import 'package:cet_hostel/resources/auth_methods.dart';
// // import 'package:cet_hostel/screens/login_screen.dart';
// // import 'package:cet_hostel/screens/new%20user/home.dart';
// // import 'package:cet_hostel/utils/colors.dart';
// // import 'package:cet_hostel/utils/utils.dart';
// // import 'package:flutter/material.dart';
// // import 'package:image_picker/image_picker.dart';

// // import '../responsive/mobile_screen_layout.dart';
// // import '../responsive/responsive_layout_screen.dart';
// // import '../responsive/web_screen_layout.dart';

// // import '../widgets/text_field_input.dart';

// // class SignUpScreen extends StatefulWidget {
// //   const SignUpScreen({super.key});

// //   @override
// //   State<SignUpScreen> createState() => _SignUpScreenState();
// // }

// // class _SignUpScreenState extends State<SignUpScreen> {
// //   String selectedDistrict = 'Thiruvananthapuram';
// //   String selectedDpl = 'APL';
// //   List<String> pl = ['APL', 'BPL'];
// //   List<String> districts = [
// //     'Thiruvananthapuram',
// //     'Kollam',
// //     'Pathanamthitta',
// //     'Alappuzha',
// //     'Kottayam',
// //     'Idukki',
// //     'Ernakulam',
// //     'Thrissur',
// //     'Palakkad',
// //     'Malappuram',
// //     'Kozhikode',
// //     'Wayanad',
// //     'Kannur',
// //     'Kasaragod',
// //   ];

// //   final TextEditingController _emailcontroller = TextEditingController();
// //   final TextEditingController _passwordcontroller = TextEditingController();
// //   final TextEditingController _usernamecontroller = TextEditingController();
// //   final TextEditingController _phonecontroller = TextEditingController();
// //   final TextEditingController _rankcontroller = TextEditingController();
// //   final TextEditingController _incomecontroller = TextEditingController();
// //   Uint8List? _image;
// //   bool _isloading = false;

// //   @override
// //   void dispose() {
// //     super.dispose();
// //     _emailcontroller.dispose();
// //     _passwordcontroller.dispose();
// //     _usernamecontroller.dispose();
// //     _phonecontroller.dispose();
// //     _rankcontroller.dispose();
// //     _incomecontroller.dispose();
// //   }

// //   void selectimage() async {
// //     Uint8List im = await pickimage(ImageSource.gallery);
// //     setState(() {
// //       _image = im;
// //     });
// //   }

// //   void SignUpUser() async {
// //     setState(() {
// //       _isloading = true;
// //     });
// //     if (_emailcontroller.text.isEmpty ||
// //         _passwordcontroller.text.isEmpty ||
// //         _image!.isEmpty ||
// //         _incomecontroller.text.isEmpty ||
// //         _emailcontroller.text.isEmpty ||
// //         _phonecontroller.text.isEmpty) {
// //       showSnackBar("Some fields are missing", context);
// //       setState(() {
// //         _isloading = false;
// //       });
// //     } else {
// //       double i;
// //       double d;
// //       if (int.parse(_incomecontroller.text) >= 10000000) {
// //         i = 6;
// //       } else if (int.parse(_incomecontroller.text) >= 3600000) {
// //         i = 12;
// //       } else if (int.parse(_incomecontroller.text) >= 2400000) {
// //         i = 18;
// //       } else if (int.parse(_incomecontroller.text) >= 1800000) {
// //         i = 24;
// //       } else if (int.parse(_incomecontroller.text) >= 1200000) {
// //         i = 30;
// //       } else if (int.parse(_incomecontroller.text) >= 900000) {
// //         i = 36;
// //       } else if (int.parse(_incomecontroller.text) >= 600000) {
// //         i = 42;
// //       } else if (int.parse(_incomecontroller.text) >= 400000) {
// //         i = 48;
// //       } else if (int.parse(_incomecontroller.text) >= 300000) {
// //         i = 54;
// //       } else if (int.parse(_incomecontroller.text) >= 200000) {
// //         i = 60;
// //       } else if (int.parse(_incomecontroller.text) >= 100000) {
// //         i = 66;
// //       } else {
// //         i = 75;
// //       }
// //       switch (selectedDistrict) {
// //         case 'Thiruvananthapuram':
// //           d = 25 / 14;
// //           break;
// //         case 'Kollam':
// //           d = 2 * 25 / 14;
// //           break;
// //         case 'Pathanamthitta':
// //           d = 3 * 25 / 14;
// //           break;
// //         case 'Alappuzha':
// //           d = 4 * 25 / 14;
// //           break;
// //         case 'Kottayam':
// //           d = 5 * 25 / 14;
// //           break;
// //         case 'Idukki':
// //           d = 6 * 25 / 14;
// //           break;
// //         case 'Ernakulam':
// //           d = 7 * 25 / 14;
// //           break;
// //         case 'Thrissur':
// //           d = 8 * 25 / 14;
// //           break;
// //         case 'Palakkad':
// //           d = 9 * 25 / 14;
// //           break;
// //         case 'Malappuram':
// //           d = 10 * 25 / 14;
// //           break;
// //         case 'Kozhikode':
// //           d = 11 * 25 / 14;
// //           break;
// //         case 'Wayanad':
// //           d = 12 * 25 / 14;
// //           break;
// //         case 'Kannur':
// //           d = 13 * 25 / 14;
// //           break;
// //         case 'Kasaragod':
// //           d = 14 * 25 / 14;
// //           break;
// //         default:
// //           d = 0; // Default value if the district is not found
// //       }
// //       String dd = (d + i).toString();
// //       print(dd);
// //       String res = await AuthMethods().SignUpUser(
// //         email: _emailcontroller.text,
// //         password: _passwordcontroller.text,
// //         username: _usernamecontroller.text,
// //         phone: _phonecontroller.text,
// //         type: 'Student',
// //         file: _image!,
// //         district: selectedDistrict,
// //         pl: selectedDpl,
// //         income: _incomecontroller.text,
// //         totel: dd,
// //       );
// //       setState(() {
// //         _isloading = false;
// //       });
// //       if (res != 'Success') {
// //         showSnackBar(res, context);
// //       } else {
// //         print("no problem++++++++++++++++++++++++++++++++++++++=");
// //         Navigator.of(context).pushReplacement(
// //           MaterialPageRoute(builder: (context) => newhome()),
// //         );
// //       }
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     double w = MediaQuery.of(context).size.width;
// //     double h = MediaQuery.of(context).size.height;
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       body: SingleChildScrollView(
// //         child: Container(
// //           padding: EdgeInsets.symmetric(),
// //           width: double.infinity,
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.center,
// //             children: [
// //               const SizedBox(
// //                 height: 84,
// //               ),
// //               image
// //               Stack(
// //                 children: [
// //                   _image != null
// //                       ? CircleAvatar(
// //                           radius: 84,
// //                           backgroundImage: MemoryImage(_image!),
// //                         )
// //                       : const CircleAvatar(
// //                           radius: 84,
// //                           backgroundImage: AssetImage("assets/images/pro1.jpg"),
// //                         ),
// //                   Positioned(
// //                     bottom: -10,
// //                     left: 90,
// //                     child: IconButton(
// //                       onPressed: selectimage,
// //                       icon: const Icon(
// //                         Icons.add_a_photo,
// //                         color: Colors.white,
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //               const SizedBox(
// //                 height: 46,
// //               ),
// //               ignore: prefer_const_constructors
// //               Text(
// //                 "College of Engineering Trivandrum",
// //                 style: TextStyle(
// //                   fontSize: 36,
// //                   height: h * 0.000001,
// //                   fontFamily: 'Cookie-Regular',
// //                 ),
// //               ),
// //               const SizedBox(
// //                 height: 46,
// //               ),
// //               textfield for username
// //               Container(
// //                 margin: const EdgeInsets.only(left: 20, right: 20),
// //                 decoration: BoxDecoration(
// //                   borderRadius: BorderRadius.circular(30),
// //                   color: Colors.white,
// //                   boxShadow: [
// //                     BoxShadow(
// //                       blurRadius: 10,
// //                       spreadRadius: 7,
// //                       offset: Offset(1, 1),
// //                       color: Colors.white.withOpacity(0.2),
// //                     ),
// //                   ],
// //                 ),
// //                 child: Column(children: [
// //                   TextFieldInput(
// //                     hinttext: ' Enter username',
// //                     textInputType: TextInputType.text,
// //                     textEditingController: _usernamecontroller,
// //                   )
// //                 ]),
// //               ),
// //               SizedBox(
// //                 height: 20,
// //               ),
// //               textfield for phoneno
// //               Container(
// //                 margin: const EdgeInsets.only(left: 20, right: 20),
// //                 decoration: BoxDecoration(
// //                   borderRadius: BorderRadius.circular(30),
// //                   color: Colors.white,
// //                   boxShadow: [
// //                     BoxShadow(
// //                       blurRadius: 10,
// //                       spreadRadius: 7,
// //                       offset: Offset(1, 1),
// //                       color: Colors.white.withOpacity(0.2),
// //                     ),
// //                   ],
// //                 ),
// //                 child: Column(children: [
// //                   TextFieldInput(
// //                     hinttext: ' Enter phoneno',
// //                     textInputType: TextInputType.phone,
// //                     textEditingController: _phonecontroller,
// //                   )
// //                 ]),
// //               ),
// //               SizedBox(
// //                 height: 20,
// //               ),

// //               textfield for email

// //               Container(
// //                 margin: const EdgeInsets.only(left: 20, right: 20),
// //                 decoration: BoxDecoration(
// //                   borderRadius: BorderRadius.circular(30),
// //                   color: Colors.white,
// //                   boxShadow: [
// //                     BoxShadow(
// //                       blurRadius: 10,
// //                       spreadRadius: 7,
// //                       offset: Offset(1, 1),
// //                       color: Colors.white.withOpacity(0.2),
// //                     ),
// //                   ],
// //                 ),
// //                 child: Column(children: [
// //                   TextFieldInput(
// //                     hinttext: ' Enter email',
// //                     textInputType: TextInputType.emailAddress,
// //                     textEditingController: _emailcontroller,
// //                   )
// //                 ]),
// //               ),

// //               SizedBox(
// //                 height: 20,
// //               ),
// //               SizedBox(
// //                 height: 20,
// //               ),
// //               textfield for phoneno

// //               Container(
// //                 margin: const EdgeInsets.only(left: 20, right: 20),
// //                 decoration: BoxDecoration(
// //                   borderRadius: BorderRadius.circular(30),
// //                   color: Colors.white,
// //                   boxShadow: [
// //                     BoxShadow(
// //                       blurRadius: 10,
// //                       spreadRadius: 7,
// //                       offset: Offset(1, 1),
// //                       color: Colors.white.withOpacity(0.2),
// //                     ),
// //                   ],
// //                 ),
// //                 child: Column(children: [
// //                   TextFieldInput(
// //                     hinttext: ' Enter income',
// //                     textInputType: TextInputType.phone,
// //                     textEditingController: _incomecontroller,
// //                   )
// //                 ]),
// //               ),
// //               SizedBox(
// //                 height: 20,
// //               ),
// //               DropdownButtonHideUnderline(
// //                 child: DropdownButton<String>(
// //                   value: selectedDistrict,
// //                   hint: Text('Select District'),
// //                   onChanged: (String? newValue) {
// //                     setState(() {
// //                       selectedDistrict = newValue!;
// //                     });
// //                   },
// //                   items:
// //                       districts.map<DropdownMenuItem<String>>((String value) {
// //                     return DropdownMenuItem<String>(
// //                       value: value,
// //                       child: Text(value),
// //                     );
// //                   }).toList(),
// //                 ),
// //               ),
// //               SizedBox(
// //                 height: 20,
// //               ),
// //               DropdownButtonHideUnderline(
// //                 child: DropdownButton<String>(
// //                   value: selectedDpl,
// //                   hint: Text('Select Pl'),
// //                   onChanged: (String? newValue) {
// //                     setState(() {
// //                       selectedDpl = newValue!;
// //                     });
// //                   },
// //                   items: pl.map<DropdownMenuItem<String>>((String value) {
// //                     return DropdownMenuItem<String>(
// //                       value: value,
// //                       child: Text(value),
// //                     );
// //                   }).toList(),
// //                 ),
// //               ),
// //               SizedBox(
// //                 height: 20,
// //               ),
// //               textfield for password
// //               Container(
// //                 margin: const EdgeInsets.only(left: 20, right: 20),
// //                 decoration: BoxDecoration(
// //                   borderRadius: BorderRadius.circular(30),
// //                   color: Colors.white,
// //                   boxShadow: [
// //                     BoxShadow(
// //                       blurRadius: 10,
// //                       spreadRadius: 7,
// //                       offset: Offset(1, 1),
// //                       color: Colors.white.withOpacity(0.2),
// //                     ),
// //                   ],
// //                 ),
// //                 child: Column(children: [
// //                   TextFieldInput(
// //                     hinttext: ' Enter password',
// //                     textInputType: TextInputType.text,
// //                     textEditingController: _passwordcontroller,
// //                     isPass: true,
// //                   )
// //                 ]),
// //               ),
// //               SizedBox(
// //                 height: 20,
// //               ),
// //               Row(
// //                 children: [
// //                   Expanded(
// //                     child: Container(),
// //                   ),
// //                   Text(
// //                     "Forgot your Password?  ",
// //                     style: TextStyle(fontSize: 15, color: Colors.black),
// //                   ),
// //                 ],
// //               ),
// //               SizedBox(
// //                 height: 26,
// //               ),
// //               button

// //               Container(
// //                 width: w * 0.5,
// //                 height: h * 0.08,
// //                 decoration: BoxDecoration(
// //                   borderRadius: BorderRadius.circular(20),
// //                   image: DecorationImage(
// //                       image: AssetImage(
// //                         "assets/images/grey2.jpg",
// //                       ),
// //                       fit: BoxFit.cover),
// //                 ),
// //                 child: Center(
// //                   child: InkWell(
// //                     onTap: SignUpUser,
// //                     child: _isloading
// //                         ? const Center(
// //                             child: CircularProgressIndicator(
// //                               color: primaryColor,
// //                             ),
// //                           )
// //                         : const Text(
// //                             "Sign up",
// //                             style: TextStyle(
// //                                 fontSize: 26,
// //                                 fontWeight: FontWeight.bold,
// //                                 color: Colors.white),
// //                           ),
// //                   ),
// //                 ),
// //               ),
// //               SizedBox(
// //                 height: w * 0.04,
// //               ),
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   Container(
// //                     child: Text('Already have an account? '),
// //                   ),
// //                   GestureDetector(
// //                     child: Text(
// //                       "Sign in",
// //                       style: TextStyle(
// //                           color: Colors.black,
// //                           fontSize: 15,
// //                           fontWeight: FontWeight.bold),
// //                     ),
// //                     onTap: () {
// //                       Navigator.of(context).push(MaterialPageRoute(
// //                           builder: (context) => LoginScreen()));
// //                     },
// //                   )
// //                 ],
// //               ),
// //               child: const Text('Log in'),
// //               width: double.infinity,
// //               alignment: Alignment.center,
// //               padding: const EdgeInsets.symmetric(vertical: 12),
// //               decoration: const ShapeDecoration(
// //                 shape: RoundedRectangleBorder(
// //                   borderRadius: BorderRadius.all(
// //                     Radius.circular(
// //                       4,
// //                     ),
// //                   ),
// //                 ),
// //                 color: gre
// //               ),

// //               transition to signup
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'dart:typed_data';

// import 'package:cet_hostel/resources/auth_methods.dart';
// import 'package:cet_hostel/screens/login_screen.dart';
// import 'package:cet_hostel/utils/colors.dart';
// import 'package:cet_hostel/utils/utils.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// import '../responsive/mobile_screen_layout.dart';
// import '../responsive/responsive_layout_screen.dart';
// import '../responsive/web_screen_layout.dart';
// import '../widgets/text_field_input.dart';

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});

//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   final TextEditingController _emailcontroller = TextEditingController();
//   final TextEditingController _passwordcontroller = TextEditingController();
//   final TextEditingController _usernamecontroller = TextEditingController();
//   final TextEditingController _phonecontroller = TextEditingController();
//   Uint8List? _image;
//   bool _isloading = false;

//   @override
//   void dispose() {
//     super.dispose();
//     _emailcontroller.dispose();
//     _passwordcontroller.dispose();
//     _usernamecontroller.dispose();
//     _phonecontroller.dispose();
//   }

//   void selectimage() async {
//     Uint8List im = await pickimage(ImageSource.gallery);
//     setState(() {
//       _image = im;
//     });
//   }

//   void SignUpUser() async {
//     setState(() {
//       _isloading = true;
//     });
//     if (_emailcontroller.text.isEmpty ||
//         _passwordcontroller.text.isEmpty ||
//         _image!.isEmpty) {
//       showSnackBar("Some fields are missing", context);
//       setState(() {
//         _isloading = false;
//       });
//     } else {
//       String res = await AuthMethods().SignUpUser(
//         email: _emailcontroller.text,
//         password: _passwordcontroller.text,
//         username: _usernamecontroller.text,
//         phone: _phonecontroller.text,
//         file: _image!,
//         type: 'Student',
//       );
//       setState(() {
//         _isloading = false;
//       });
//       if (res != 'Success') {
//         showSnackBar(res, context);
//       } else {
//         Navigator.of(context).pushReplacement(
//           MaterialPageRoute(
//             builder: (context) => const ResponsiveLayout(
//               MobileScreenLayout: MobileScreenLayout(),
//               WebScreenLayout: WebScreenLayout(),
//             ),
//           ),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     double w = MediaQuery.of(context).size.width;
//     double h = MediaQuery.of(context).size.height;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.symmetric(),
//           width: double.infinity,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const SizedBox(
//                 height: 84,
//               ),
//               // image
//               Stack(
//                 children: [
//                   _image != null
//                       ? CircleAvatar(
//                           radius: 84,
//                           backgroundImage: MemoryImage(_image!),
//                         )
//                       : const CircleAvatar(
//                           radius: 84,
//                           backgroundImage: AssetImage("assets/images/pro1.jpg"),
//                         ),
//                   Positioned(
//                     bottom: -10,
//                     left: 90,
//                     child: IconButton(
//                       onPressed: selectimage,
//                       icon: const Icon(
//                         Icons.add_a_photo,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 46,
//               ),
//               // ignore: prefer_const_constructors
//               Text(
//                 "College of Engineering Trivandrum",
//                 style: TextStyle(
//                   fontSize: 36,
//                   height: h * 0.000001,
//                   fontFamily: 'Cookie-Regular',
//                 ),
//               ),
//               const SizedBox(
//                 height: 46,
//               ),
//               //textfield for username
//               Container(
//                 margin: const EdgeInsets.only(left: 20, right: 20),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(30),
//                   color: Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                       blurRadius: 10,
//                       spreadRadius: 7,
//                       offset: Offset(1, 1),
//                       color: Colors.white.withOpacity(0.2),
//                     ),
//                   ],
//                 ),
//                 child: Column(children: [
//                   TextFieldInput(
//                     hinttext: ' Enter username',
//                     textInputType: TextInputType.text,
//                     textEditingController: _usernamecontroller,
//                   )
//                 ]),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               //textfield for phoneno
//               Container(
//                 margin: const EdgeInsets.only(left: 20, right: 20),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(30),
//                   color: Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                       blurRadius: 10,
//                       spreadRadius: 7,
//                       offset: Offset(1, 1),
//                       color: Colors.white.withOpacity(0.2),
//                     ),
//                   ],
//                 ),
//                 child: Column(children: [
//                   TextFieldInput(
//                     hinttext: ' Enter phoneno',
//                     textInputType: TextInputType.phone,
//                     textEditingController: _phonecontroller,
//                   )
//                 ]),
//               ),
//               SizedBox(
//                 height: 20,
//               ),

//               //textfield for email

//               Container(
//                 margin: const EdgeInsets.only(left: 20, right: 20),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(30),
//                   color: Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                       blurRadius: 10,
//                       spreadRadius: 7,
//                       offset: Offset(1, 1),
//                       color: Colors.white.withOpacity(0.2),
//                     ),
//                   ],
//                 ),
//                 child: Column(children: [
//                   TextFieldInput(
//                     hinttext: ' Enter email',
//                     textInputType: TextInputType.emailAddress,
//                     textEditingController: _emailcontroller,
//                   )
//                 ]),
//               ),

//               SizedBox(
//                 height: 20,
//               ),
//               // textfield for password
//               Container(
//                 margin: const EdgeInsets.only(left: 20, right: 20),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(30),
//                   color: Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                       blurRadius: 10,
//                       spreadRadius: 7,
//                       offset: Offset(1, 1),
//                       color: Colors.white.withOpacity(0.2),
//                     ),
//                   ],
//                 ),
//                 child: Column(children: [
//                   TextFieldInput(
//                     hinttext: ' Enter password',
//                     textInputType: TextInputType.text,
//                     textEditingController: _passwordcontroller,
//                     isPass: true,
//                   )
//                 ]),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: Container(),
//                   ),
//                   Text(
//                     "Forgot your Password?  ",
//                     style: TextStyle(fontSize: 15, color: Colors.black),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 26,
//               ),
//               // button

//               Container(
//                 width: w * 0.5,
//                 height: h * 0.08,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   image: DecorationImage(
//                       image: AssetImage(
//                         "assets/images/grey2.jpg",
//                       ),
//                       fit: BoxFit.cover),
//                 ),
//                 child: Center(
//                   child: InkWell(
//                     onTap: SignUpUser,
//                     child: _isloading
//                         ? const Center(
//                             child: CircularProgressIndicator(
//                               color: primaryColor,
//                             ),
//                           )
//                         : const Text(
//                             "Sign up",
//                             style: TextStyle(
//                                 fontSize: 26,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white),
//                           ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: w * 0.04,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     child: Text('Already have an account? '),
//                   ),
//                   GestureDetector(
//                     child: Text(
//                       "Sign in",
//                       style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 15,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     onTap: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => LoginScreen()));
//                     },
//                   )
//                 ],
//               ),
//               //child: const Text('Log in'),
//               // width: double.infinity,
//               // alignment: Alignment.center,
//               // padding: const EdgeInsets.symmetric(vertical: 12),
//               // decoration: const ShapeDecoration(
//               //   shape: RoundedRectangleBorder(
//               //     borderRadius: BorderRadius.all(
//               //       Radius.circular(
//               //         4,
//               //       ),
//               //     ),
//               //   ),
//               //   color: gre
//               // ),

//               // transition to signup
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
