import 'package:flutter/material.dart';

class HostelHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('College Hostel App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Hostel Details',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Name: XYZ Hostel',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Location: ABC Area, City',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Facilities: Wi-Fi, 24x7 Water Supply, Security, etc.',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Hostel Photos',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  HostelPhotoCard(
                    imageUrl: 'https://unsplash.com/photos/T1Yvmf4oleQ',
                    caption: 'Hostel Exterior',
                  ),
                  // HostelPhotoCard(
                  //   imageUrl:
                  //       'https://images.unsplash.com/photo-1626190900453-fdb22bfed7a9',
                  //   caption: 'Hostel Lounge',
                  // ),
                  // HostelPhotoCard(
                  //   imageUrl:
                  //       'https://images.unsplash.com/photo-1582400062306-77e6b2294d57',
                  //   caption: 'Hostel Room',
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HostelPhotoCard extends StatelessWidget {
  final String imageUrl;
  final String caption;

  const HostelPhotoCard(
      {Key? key, required this.imageUrl, required this.caption})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              caption,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
