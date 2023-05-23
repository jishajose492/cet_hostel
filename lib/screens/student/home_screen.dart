import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class CarouselSliderExample extends StatelessWidget {
  final List<String> imageUrls = [
    'assets/images/img2.jpg',
    'assets/images/h4.jpg',
    'assets/images/img1.jpg',
    'assets/images/h3.jpg',
    'assets/images/h2.jpg',
    'assets/images/h1.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 60),
          SizedBox(
            width: double.infinity,
            child: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFFE0E0E0),
                  width: .1,
                ),
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFE0E0E0),
                    offset: Offset(0, 2),
                    blurRadius: 10.90,
                  ),
                ],
              ),
              child: Text(
                'CET Hostel',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Roboto', // Change font family
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            child: CarouselSlider(
              options: CarouselOptions(
                height: 170.0,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
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
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            var phoneNumber = 'tel:0471 2515502';
                            if (await canLaunch(phoneNumber)) {
                              await launch(phoneNumber);
                            } else {
                              throw 'Could not launch $phoneNumber';
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue.withOpacity(0.2),
                            ),
                            padding: EdgeInsets.all(12.0),
                            child: FaIcon(
                              FontAwesomeIcons.phone,
                              color: Colors.blue,
                              size: 24.0,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Phone Number',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                fontFamily: 'Roboto', // Change font family
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              "0471 2515502",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey[800],
                                fontFamily: 'Roboto', // Change font family
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final Uri emailUri = Uri(
                              scheme: 'mailto',
                              path: "principal@cet.ac.in",
                            );

                            if (await canLaunch(emailUri.toString())) {
                              await launch(emailUri.toString());
                            } else {
                              throw 'Could not launch email';
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red.withOpacity(0.2),
                            ),
                            padding: EdgeInsets.all(12.0),
                            child: Icon(
                              Icons.email,
                              color: Colors.red,
                              size: 24.0,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                                fontFamily: 'Roboto', // Change font family
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              "principal@cet.ac.in",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey[800],
                                fontFamily: 'Roboto', // Change font family
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Men’s Hostel',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto', // Change font family
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'The men’s hostel is situated behind the college within the campus amidst a glistening panoramic view.',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey[800],
                          fontFamily: 'Roboto', // Change font family
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Women’s Hostel',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto', // Change font family
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'The Women’s hostel is located on the front side of the college in a beautiful location amidst greenish scenery.',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey[800],
                          fontFamily: 'Roboto', // Change font family
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Facilities',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto', // Change font family
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Both hostels provide a comfortable and conducive atmosphere to develop the innate abilities of inmates. Indoor and outdoor facilities for sports and cultural activities (Reading rooms, Fitness centres with modern scientific equipment) are available in both hostels.',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey[800],
                          fontFamily: 'Roboto', // Change font family
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
   




   


// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';

// class CarouselSliderExample extends StatelessWidget {
//   final List<String> imageUrls = [
//     'assets/images/img2.jpg',
//     'assets/images/h4.jpg',
//     'assets/images/img1.jpg',
//     'assets/images/h3.jpg',
//     'assets/images/h2.jpg',
//     'assets/images/h1.jpg',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text('Carousel Slider Example'),
//       // ),
//       body: Column(
//         children: [
//           SizedBox(
//             height: 60,
//           ),
//           SizedBox(
//             width: double.infinity,
//             child: Container(
//               padding: EdgeInsets.all(16.0),
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: Color(0xFFE0E0E0),
//                   width: .1,
//                 ),
//                 borderRadius: BorderRadius.circular(8.0),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Color(0xFFE0E0E0),
//                     offset: Offset(0, 2),
//                     blurRadius: 10.90,
//                   ),
//                 ],
//               ),
//               child: Text(
//                 'CET Hostel',
//                 style: TextStyle(
//                   fontSize: 24.0,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Container(
//             child: CarouselSlider(
//               options: CarouselOptions(
//                 height: 170.0,
//                 autoPlay: true,
//                 enlargeCenterPage: true,
//                 aspectRatio: 16 / 9,
//                 autoPlayCurve: Curves.fastOutSlowIn,
//                 enableInfiniteScroll: true,
//                 autoPlayAnimationDuration: Duration(milliseconds: 800),
//                 viewportFraction: 0.8,
//               ),
//               items: imageUrls.map((imageUrl) {
//                 return Builder(
//                   builder: (BuildContext context) {
//                     return Container(
//                       width: MediaQuery.of(context).size.width,
//                       margin: EdgeInsets.symmetric(horizontal: 5.0),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10.0),
//                         color: Colors.white,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black26,
//                             offset: Offset(0, 2),
//                             blurRadius: 6.0,
//                           ),
//                         ],
//                       ),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(10.0),
//                         child: Stack(
//                           children: [
//                             Image.asset(
//                               imageUrl,
//                               fit: BoxFit.cover,
//                               width: double.infinity,
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                 gradient: LinearGradient(
//                                   begin: Alignment.topCenter,
//                                   end: Alignment.bottomCenter,
//                                   colors: [
//                                     Colors.transparent,
//                                     Colors.black.withOpacity(0.5),
//                                     Colors.black.withOpacity(0.8),
//                                   ],
//                                   stops: [0.0, 0.6, 1.0],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               }).toList(),
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Container(
//             width: double.infinity,
//             child: Card(
//               elevation: 4.0,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         GestureDetector(
//                           onTap: () async {
//                             var phoneNumber = 'tel:0471 2515502';
//                             // 'tel:+1234567890'; // replace with the actual phone number
//                             if (await canLaunch(phoneNumber)) {
//                               await launch(phoneNumber);
//                             } else {
//                               throw 'Could not launch $phoneNumber';
//                             }
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: Colors.blue.withOpacity(0.2),
//                             ),
//                             padding: EdgeInsets.all(12.0),
//                             child: FaIcon(
//                               FontAwesomeIcons.phone,
//                               color: Colors.blue,
//                               size: 24.0,
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 12.0),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Phone Number',
//                               style: TextStyle(
//                                 fontSize: 18.0,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.blue,
//                               ),
//                             ),
//                             SizedBox(height: 4.0),
//                             Text(
//                               "0471 2515502",
//                               style: TextStyle(
//                                 fontSize: 16.0,
//                                 color: Colors.grey[800],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 16.0),
//                     Row(
//                       children: [
//                         GestureDetector(
//                           onTap: () async {
//                             final Uri emailUri = Uri(
//                               scheme: 'mailto',
//                               path: "principal@cet.ac.in",
//                             );

//                             if (await canLaunch(emailUri.toString())) {
//                               await launch(emailUri.toString());
//                             } else {
//                               throw 'Could not launch email';
//                             }
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: Colors.red.withOpacity(0.2),
//                             ),
//                             padding: EdgeInsets.all(12.0),
//                             child: Icon(
//                               Icons.email,
//                               color: Colors.red,
//                               size: 24.0,
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 12.0),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Email',
//                               style: TextStyle(
//                                 fontSize: 18.0,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.red,
//                               ),
//                             ),
//                             SizedBox(height: 4.0),
//                             Text(
//                               "principal@cet.ac.in",
//                               style: TextStyle(
//                                 fontSize: 16.0,
//                                 color: Colors.grey[800],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               padding: EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Men’s Hostel',
//                     style: TextStyle(
//                       fontSize: 24.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 8.0),
//                   Card(
//                     elevation: 4.0,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.all(16.0),
//                       child: Text(
//                         'The men’s hostel is situated behind the college within the campus amidst a glistening panoramic view.',
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           color: Colors.grey[800],
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 16.0),
//                   Text(
//                     'Women’s Hostel',
//                     style: TextStyle(
//                       fontSize: 24.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 8.0),
//                   Card(
//                     elevation: 4.0,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.all(16.0),
//                       child: Text(
//                         'The Women’s hostel is located on the front side of the college in a beautiful location amidst greenish scenery.',
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           color: Colors.grey[800],
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 16.0),
//                   Text(
//                     'Facilities',
//                     style: TextStyle(
//                       fontSize: 24.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 8.0),
//                   Card(
//                     elevation: 4.0,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.all(16.0),
//                       child: Text(
//                         'Both hostels provide a comfortable and conducive atmosphere to develop the innate abilities of inmates. Indoor and outdoor facilities for sports and cultural activities (Reading rooms, Fitness centres with modern scientific equipment) are available in both hostels.',
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           color: Colors.grey[800],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
