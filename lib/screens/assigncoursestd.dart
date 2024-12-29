import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AssignCourseScreen extends StatefulWidget {
  const AssignCourseScreen({Key? key}) : super(key: key);

  @override
  _AssignCourseScreenState createState() => _AssignCourseScreenState();
}

class _AssignCourseScreenState extends State<AssignCourseScreen> {
  String? selectedStudentId;
  String? selectedCourseId;

  // Method to fetch students from Firebase
  Stream<DatabaseEvent> getStudents() {
    return FirebaseDatabase.instance.ref('students').onValue;
  }

  // Method to fetch courses from Firebase
  Stream<DatabaseEvent> getCourses() {
    return FirebaseDatabase.instance.ref('courses').onValue;
  }

  // Method to assign course to a student
  void assignCourseToStudent() {
    if (selectedStudentId != null && selectedCourseId != null) {
      final DatabaseReference studentRef = FirebaseDatabase.instance
          .ref('students/$selectedStudentId/enrolledCourses');
      final DatabaseReference courseRef = FirebaseDatabase.instance
          .ref('courses/$selectedCourseId/enrolledStudents');

      // Add course to student's enrolled courses
      studentRef.push().set(selectedCourseId).then((_) {
        // Add student to course's enrolled students
        courseRef.push().set(selectedStudentId).then((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Course assigned successfully')),
          );
          setState(() {
            selectedStudentId = null;
            selectedCourseId = null;
          });
        });
      }).catchError((error) {
        // Handle any errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to assign course: $error')),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select both student and course')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green, // Changed app bar color to green
        title: const Text('Assign Course to Student'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Student selection section
            const Text(
              'Select Student',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            StreamBuilder(
              stream: getStudents(),
              builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
                  final Map<dynamic, dynamic> studentsData =
                      snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
                  return DropdownButtonFormField<String>(
                    isExpanded: true,
                    value: selectedStudentId,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                    hint: const Text('Select a student'),
                    items: studentsData.entries.map((entry) {
                      final student = entry.value;
                      return DropdownMenuItem<String>(
                        value: entry.key,
                        child: Text(student['name']),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedStudentId = newValue;
                      });
                    },
                  );
                } else {
                  return const Text('No students available.');
                }
              },
            ),
            const SizedBox(height: 20),

            // Course selection section
            const Text(
              'Select Course',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            StreamBuilder(
              stream: getCourses(),
              builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
                  final Map<dynamic, dynamic> coursesData =
                      snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
                  return DropdownButtonFormField<String>(
                    isExpanded: true,
                    value: selectedCourseId,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                    hint: const Text('Select a course'),
                    items: coursesData.entries.map((entry) {
                      final course = entry.value;
                      return DropdownMenuItem<String>(
                        value: entry.key,
                        child: Text(course['name']),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCourseId = newValue;
                      });
                    },
                  );
                } else {
                  return const Text('No courses available.');
                }
              },
            ),
            const SizedBox(height: 30),

            // Button to assign course to student
            ElevatedButton(
              onPressed: assignCourseToStudent,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
                backgroundColor: Colors.green, // Button color to match app bar
              ),
              child: const Text(
                'Assign Course',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
