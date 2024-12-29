// import 'package:flutter/material.dart';

// class CourseManagement extends StatefulWidget {
//   @override
//   _CourseManagementState createState() => _CourseManagementState();
// }

// class _CourseManagementState extends State<CourseManagement> {
//   // Controllers for input fields
//   final TextEditingController courseIdController = TextEditingController();
//   final TextEditingController courseNameController = TextEditingController();
//   final TextEditingController instructorController = TextEditingController();
//   String selectedDay = 'Monday';
//   final TextEditingController startTimeController = TextEditingController();
//   final TextEditingController endTimeController = TextEditingController();

//   // List to hold course details
//   List<Map<String, String>> courses = [
//     {
//       'id': 'CSE001',
//       'name': 'Internet of Things',
//       'instructor': 'Dr. Shafaat Ali Sheikh'
//     },
//     {
//       'id': 'CSE002',
//       'name': 'Network Security',
//       'instructor': 'Dr. Narmeen Shafqat'
//     },
//     {
//       'id': 'CSE003',
//       'name': 'Cloud Computing',
//       'instructor': 'Dr. Nomica Mukhtar'
//     },
//   ];

//   // Method to add new course
//   void addCourse() {
//     setState(() {
//       courses.add({
//         'id': courseIdController.text,
//         'name': courseNameController.text,
//         'instructor': instructorController.text,
//       });
//       // Clear fields
//       courseIdController.clear();
//       courseNameController.clear();
//       instructorController.clear();
//       startTimeController.clear();
//       endTimeController.clear();
//     });
//   }

//   // Method to delete course
//   void deleteCourse(int index) {
//     setState(() {
//       courses.removeAt(index);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Course Management'),
//         backgroundColor: Colors.green, // Set the AppBar color to green
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Add New Course',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: courseIdController,
//                     decoration: const InputDecoration(
//                       labelText: 'Course ID',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: TextField(
//                     controller: courseNameController,
//                     decoration: const InputDecoration(
//                       labelText: 'Course Name',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             TextField(
//               controller: instructorController,
//               decoration: const InputDecoration(
//                 labelText: 'Instructor Name',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'Course Schedule',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             Row(
//               children: [
//                 DropdownButton<String>(
//                   value: selectedDay,
//                   items: <String>[
//                     'Monday',
//                     'Tuesday',
//                     'Wednesday',
//                     'Thursday',
//                     'Friday'
//                   ].map<DropdownMenuItem<String>>((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       selectedDay = newValue!;
//                     });
//                   },
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: TextField(
//                     controller: startTimeController,
//                     decoration: const InputDecoration(
//                       labelText: 'Start Time (HH:MM)',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: TextField(
//                     controller: endTimeController,
//                     decoration: const InputDecoration(
//                       labelText: 'End Time (HH:MM)',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton.icon(
//                 onPressed: addCourse,
//                 icon: const Icon(Icons.add),
//                 label: const Text('Add Course'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green, // Button color green
//                   padding: const EdgeInsets.symmetric(vertical: 15),
//                   textStyle: const TextStyle(fontSize: 16),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'Course List',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: courses.length,
//                 itemBuilder: (context, index) {
//                   return Card(
//                     elevation: 4,
//                     margin: const EdgeInsets.symmetric(vertical: 8),
//                     child: ListTile(
//                       title: Text(courses[index]['name']!),
//                       subtitle:
//                           Text('Instructor: ${courses[index]['instructor']}'),
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                             icon: const Icon(Icons.visibility),
//                             onPressed: () {
//                               // Implement view functionality
//                             },
//                           ),
//                           IconButton(
//                             icon: const Icon(Icons.delete),
//                             onPressed: () {
//                               deleteCourse(index);
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class CourseManagement extends StatefulWidget {
  @override
  _CourseManagementState createState() => _CourseManagementState();
}

class _CourseManagementState extends State<CourseManagement> {
  // Controllers for input fields
  final TextEditingController courseIdController = TextEditingController();
  final TextEditingController courseNameController = TextEditingController();
  final TextEditingController instructorController = TextEditingController();
  String selectedDay = 'Monday';
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();

  final DatabaseReference database =
      FirebaseDatabase.instance.ref().child('courses');

  // Method to add new course to Realtime Database
  void addCourseToDatabase() async {
    String courseId = courseIdController.text;
    String courseName = courseNameController.text;
    String instructor = instructorController.text;
    String startTime = startTimeController.text;
    String endTime = endTimeController.text;

    if (courseId.isEmpty ||
        courseName.isEmpty ||
        instructor.isEmpty ||
        startTime.isEmpty ||
        endTime.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    try {
      // Add course data to Realtime Database under the 'courses' node
      await database.child(courseId).set({
        'id': courseId,
        'name': courseName,
        'instructor': instructor,
        'day': selectedDay,
        'start_time': startTime,
        'end_time': endTime,
      });

      // Clear fields after adding the course
      courseIdController.clear();
      courseNameController.clear();
      instructorController.clear();
      startTimeController.clear();
      endTimeController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Course added successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add course: $e')),
      );
    }
  }

  // Method to delete course from Realtime Database
  void deleteCourse(String courseId) async {
    try {
      await database.child(courseId).remove();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Course deleted successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete course: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Management'),
        backgroundColor: Colors.green, // Set the AppBar color to green
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add New Course',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: courseIdController,
                    decoration: const InputDecoration(
                      labelText: 'Course ID',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: courseNameController,
                    decoration: const InputDecoration(
                      labelText: 'Course Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextField(
              controller: instructorController,
              decoration: const InputDecoration(
                labelText: 'Instructor Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Course Schedule',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                DropdownButton<String>(
                  value: selectedDay,
                  items: <String>[
                    'Monday',
                    'Tuesday',
                    'Wednesday',
                    'Thursday',
                    'Friday'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedDay = newValue!;
                    });
                  },
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: startTimeController,
                    decoration: const InputDecoration(
                      labelText: 'Start Time (HH:MM)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: endTimeController,
                    decoration: const InputDecoration(
                      labelText: 'End Time (HH:MM)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: addCourseToDatabase,
                icon: const Icon(Icons.add),
                label: const Text('Add Course'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Button color green
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Course List',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: StreamBuilder(
                stream: database.onValue,
                builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasData &&
                      snapshot.data!.snapshot.value != null) {
                    Map<dynamic, dynamic> coursesMap =
                        snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
                    List courses = coursesMap.values.toList();

                    return ListView.builder(
                      itemCount: courses.length,
                      itemBuilder: (context, index) {
                        var course = courses[index];
                        return Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(course['name']),
                            subtitle:
                                Text('Instructor: ${course['instructor']}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    deleteCourse(course['id']);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text('No courses available'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
