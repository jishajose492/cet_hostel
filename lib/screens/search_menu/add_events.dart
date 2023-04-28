import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddEventPosterPage extends StatefulWidget {
  @override
  _AddEventPosterPageState createState() => _AddEventPosterPageState();
}

class _AddEventPosterPageState extends State<AddEventPosterPage> {
  final _formKey = GlobalKey<FormState>();
  final _eventNameController = TextEditingController();
  final _eventDateController = TextEditingController();
  final _eventDescriptionController = TextEditingController();
  File? _posterImage;

  @override
  void dispose() {
    _eventNameController.dispose();
    _eventDateController.dispose();
    _eventDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Add Event',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: _selectPosterImage,
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    child: _posterImage != null
                        ? Image.file(_posterImage!, fit: BoxFit.cover)
                        : Center(
                            child: Icon(Icons.image, size: 50),
                          ),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _eventNameController,
                  decoration: InputDecoration(labelText: 'Event Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter event name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _eventDateController,
                  decoration: InputDecoration(labelText: 'Event Date'),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 365)),
                    );
                    if (pickedDate != null) {
                      _eventDateController.text =
                          DateFormat('dd/MM/yyyy').format(pickedDate);
                    }
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please select event date';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _eventDescriptionController,
                  maxLines: 5,
                  decoration: InputDecoration(labelText: 'Event Description'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter event description';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _addEvent();
                    }
                  },
                  child: Text('Add Event'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _selectPosterImage() async {
    final pickedFile =
        // ignore: deprecated_member_use
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _posterImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _addEvent() async {
    final _firestore = FirebaseFirestore.instance;

    // Generate a unique ID for the event
    String eventId = _firestore.collection('events').doc().id;

    // Upload the poster image to Firebase Storage and get the URL
    Reference storageReference =
        FirebaseStorage.instance.ref().child('event_posters/$eventId.jpg');
    UploadTask uploadTask = storageReference.putFile(_posterImage!);
    await uploadTask.whenComplete(() {});

    String posterImageUrl = await storageReference.getDownloadURL();

    // Create a map with the event data
    Map<String, dynamic> eventData = {
      'event_id': eventId,
      'event_name': _eventNameController.text,
      'event_date': _eventDateController.text,
      'event_description': _eventDescriptionController.text,
      'poster_image_url': posterImageUrl,
    };

    // Save the event data to Firestore
    await _firestore.collection('events').doc(eventId).set(eventData);

    // Show a success message to the user and navigate back to the previous screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Event added successfully!'),
        duration: Duration(seconds: 3),
      ),
    );
    Navigator.pop(context);
  }
}
