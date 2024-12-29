import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewFile extends StatefulWidget {
  const NewFile({super.key});

  @override
  State<NewFile> createState() => _NewFileState();
}

class _NewFileState extends State<NewFile> {
  // Database reference
  // final db = FirebaseDatabase.instance.ref(
  //     'https://smart-attendance-system-d6ed0-default-rtdb.firebaseio.com/attendance');

  final field = TextEditingController(); // Text controller for the input field

  // Function to add value to Firebase
  // void addval() async {
  //   try {
  //     // Sanitize the input to remove invalid characters and whitespace
  //     String sanitizedFieldText = field.text
  //         .replaceAll(RegExp(r'[.#$[\]]'), '') // Remove invalid characters
  //         .trim(); // Remove leading and trailing spaces

  //     // Log the sanitized text for debugging
  //     print("Sanitized input: '$sanitizedFieldText'");

  //     // Format the current date
  //     String date = DateFormat('yyyy-MM-dd').format(DateTime.now());

  //     // Add sanitized data to Firebase
  //     await db.set({'timestamp': date});
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add to Firebase'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input field for the data
            TextFormField(
                controller: field,
                decoration: InputDecoration(
                  labelText: 'Enter Value',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                )),
            SizedBox(
              height: 15,
            ),
            // Button to trigger adding value to Firebase
            ElevatedButton(
                onPressed: () {
                  // addval(); // Call addval() when the button is pressed
                },
                child: Text('Add'))
          ],
        ),
      ),
    );
  }
}
