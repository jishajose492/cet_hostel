import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text('Events', style: TextStyle(color: Colors.black)),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('events').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<DocumentSnapshot> documents = snapshot.data!.docs;

          if (documents.isEmpty) {
            return Center(
              child: Text('No events found.'),
            );
          }

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              Map<String, dynamic>? eventData =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>?;

              return InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.network(eventData!['poster_image_url']),
                          SizedBox(height: 16),
                          Text(
                            eventData!['event_name'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(eventData['event_description']),
                          SizedBox(height: 8),
                          Text('Date: ${eventData['event_date']}'),
                          SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Close'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: ListTile(
                  leading: eventData!['poster_image_url'] != null
                      ? Image.network(eventData['poster_image_url'], width: 60)
                      : Icon(Icons.event),
                  title: Text(eventData['event_name']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      Text('Date: ${eventData['event_date']}'),
                      SizedBox(height: 4),
                      Text('Description: ${eventData['event_description']}'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
