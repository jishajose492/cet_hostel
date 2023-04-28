import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class messbill extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mess Bill')),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('roooms')
            .doc()
            .collection('attendence')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData) {
            return Text('Loading...');
          }

          final attendence = snapshot.data!.docs;

          return ListView.builder(
            itemCount: attendence.length,
            itemBuilder: (context, index) {
              final user = attendence[index].data();
              return ListTile(
                title: Text((user as Map<String, dynamic>)['username']),
              );
            },
          );
        },
      ),
    );
  }
}
