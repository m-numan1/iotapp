// import 'package:flutter/material.dart';

// class StudentManagement extends StatefulWidget {
//   const StudentManagement({Key? key}) : super(key: key);

//   @override
//   _StudentManagementState createState() => _StudentManagementState();
// }

// class _StudentManagementState extends State<StudentManagement> {
//   // Mock data for students
//   List<Map<String, String>> students = [
//     {
//       'id': '000001',
//       'name': 'Muhammad Usman',
//       'email': 'musman421141@gmail.com'
//     },
//     {
//       'id': '000002',
//       'name': 'Muhammad Numan',
//       'email': 'meditations756@gmail.com'
//     },
//     {
//       'id': '000003',
//       'name': 'Danyal Sarwar',
//       'email': 'danyalsarwar1240@gmail.com'
//     },
//   ];

//   // Controllers for input fields
//   final TextEditingController idController = TextEditingController();
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();

//   // Method to add a new student
//   void addStudent() {
//     setState(() {
//       students.add({
//         'id': idController.text,
//         'name': nameController.text,
//         'email': emailController.text,
//       });
//       // Clear fields after adding the student
//       idController.clear();
//       nameController.clear();
//       emailController.clear();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.green,
//         title: const Text('Student Management'),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Form to add new student
//             Card(
//               elevation: 4,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     TextField(
//                       controller: idController,
//                       decoration: InputDecoration(
//                         labelText: 'Student ID',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     TextField(
//                       controller: nameController,
//                       decoration: InputDecoration(
//                         labelText: 'Full Name',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     TextField(
//                       controller: emailController,
//                       decoration: InputDecoration(
//                         labelText: 'Email',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     ElevatedButton(
//                       onPressed: addStudent,
//                       style: ElevatedButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 12, horizontal: 16),
//                       ),
//                       child: const Text('Add Student'),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 32),
//             // Student list
//             const Text(
//               'Student List',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 8),
//             ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: students.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   elevation: 4,
//                   margin: const EdgeInsets.symmetric(vertical: 8),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: ListTile(
//                     contentPadding: const EdgeInsets.all(16),
//                     title: Text(
//                       students[index]['name']!,
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('ID: ${students[index]['id']}'),
//                         Text('Email: ${students[index]['email']}'),
//                       ],
//                     ),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.edit),
//                           onPressed: () {
//                             // Implement edit functionality
//                           },
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.delete),
//                           onPressed: () {
//                             setState(() {
//                               students.removeAt(index);
//                             });
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class StudentManagement extends StatefulWidget {
  const StudentManagement({Key? key}) : super(key: key);

  @override
  _StudentManagementState createState() => _StudentManagementState();
}

class _StudentManagementState extends State<StudentManagement> {
  // Controllers for input fields
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  // Method to add a new student
  void addStudent() {
    final DatabaseReference ref = FirebaseDatabase.instance.ref('students');

    // Add student to Firebase
    ref.push().set({
      'student_id': idController.text,
      'name': nameController.text,
      'email': emailController.text,
    }).then((_) {
      // Clear fields after adding the student
      idController.clear();
      nameController.clear();
      emailController.clear();
    }).catchError((error) {
      // Handle errors if any
      print('Failed to add student: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Student Management'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Form to add new student
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: idController,
                      decoration: InputDecoration(
                        labelText: 'Student ID',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: addStudent,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                      ),
                      child: const Text('Add Student'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Student list
            const Text(
              'Student List',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            StreamBuilder(
              stream: FirebaseDatabase.instance.ref('students').onValue,
              builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
                  final Map<dynamic, dynamic> studentsData =
                      snapshot.data!.snapshot.value as Map<dynamic, dynamic>;

                  List<Map<String, String>> students = [];
                  studentsData.forEach((key, value) {
                    students.add({
                      'id': value['student_id'],
                      'name': value['name'],
                      'email': value['email'],
                    });
                  });

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      print(students);
                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          title: Text(
                            students[index]['name']!,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('ID:' + students[index]['id'].toString()),
                              Text('Email: ${students[index]['email']}'),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  // Implement edit functionality
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  // Delete student from Firebase
                                  FirebaseDatabase.instance
                                      .ref('students')
                                      .child(studentsData.keys.elementAt(index))
                                      .remove();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Text('No students found.');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
