// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';

// class AttendanceScreen extends StatefulWidget {
//   @override
//   _AttendanceScreenState createState() => _AttendanceScreenState();
// }

// class _AttendanceScreenState extends State<AttendanceScreen> {
//   String url =
//       'https://smart-attendance-system-d6ed0-default-rtdb.firebaseio.com/attendance';
//   late final DatabaseReference _database;

//   Map<dynamic, dynamic> attendanceData = {};

//   @override
//   void initState() {
//     super.initState();
//     _database = FirebaseDatabase.instance.refFromURL(url);
//     fetchAttendanceData();
//   }

//   Future<void> fetchAttendanceData() async {
//     DatabaseReference attendanceRef = _database;
//     attendanceRef.once().then((DatabaseEvent event) {
//       DataSnapshot snapshot = event.snapshot;

//       setState(() {
//         attendanceData = snapshot.value as Map<dynamic, dynamic>;
//         print(attendanceData); // Output will contain the time for the student
//       });
//     }).catchError((error) {
//       print('Error retrieving data: $error');
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Attendance Data'),
//       ),
//       body: attendanceData.isEmpty
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: attendanceData.length,
//               itemBuilder: (context, index) {
//                 // Access the date (key) for each attendance entry
//                 String date = attendanceData.keys.elementAt(index);
//                 Map<dynamic, dynamic> studentsData = attendanceData[date];

//                 return ExpansionTile(
//                   title: Text('Date: $date'),
//                   children: studentsData.keys.map<Widget>((studentName) {
//                     // Access student details (e.g., timestamp)
//                     Map<dynamic, dynamic> studentDetails =
//                         studentsData[studentName];
//                     String timestamp =
//                         studentDetails['timestamp'] ?? 'No timestamp';

//                     return ListTile(
//                       title: Text(studentName), // Display the student's name
//                       subtitle: Text(
//                           'Timestamp: $timestamp'), // Display the timestamp
//                     );
//                   }).toList(),
//                 );
//               },
//             ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';

// class AttendanceScreen extends StatefulWidget {
//   @override
//   _AttendanceScreenState createState() => _AttendanceScreenState();
// }

// class _AttendanceScreenState extends State<AttendanceScreen> {
//   String url =
//       'https://smart-attendance-system-d6ed0-default-rtdb.firebaseio.com/attendance';
//   late final DatabaseReference _database;
//   String stdurl =
//       'https://smart-attendance-system-d6ed0-default-rtdb.firebaseio.com/students';
//   List<Map<dynamic, dynamic>> attendanceData = [];
//   List<Map<dynamic, dynamic>> students = [];
//   late final DatabaseReference stddb;
//   @override
//   void initState() {
//     super.initState();
//     stddb = FirebaseDatabase.instance.refFromURL(stdurl);
//     _database = FirebaseDatabase.instance.refFromURL(url);
//     fetchAttendanceData();
//     fetchstdentsData();
//   }

//   Future<void> fetchstdentsData() async {
//     DatabaseReference attendanceRef = stddb;
//     attendanceRef.once().then((DatabaseEvent event) {
//       DataSnapshot snapshot = event.snapshot;

//       // Extract attendance data and store it in a list
//       setState(() {
//         if (snapshot.value != null) {
//           Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;

//           // Cast the data to the correct type
//           students = List<Map<dynamic, dynamic>>.from(
//               data.values.map((value) => value as Map<dynamic, dynamic>));

//           print(students); // Output the list of attendance records
//         }
//       });
//     }).catchError((error) {
//       print('Error retrieving data: $error');
//     });
//   }

//   Future<void> fetchAttendanceData() async {
//     DatabaseReference attendanceRef = _database;
//     attendanceRef.once().then((DatabaseEvent event) {
//       DataSnapshot snapshot = event.snapshot;

//       // Extract attendance data and store it in a list
//       setState(() {
//         if (snapshot.value != null) {
//           Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;

//           // Cast the data to the correct type
//           attendanceData = List<Map<dynamic, dynamic>>.from(
//               data.values.map((value) => value as Map<dynamic, dynamic>));

//           print(attendanceData); // Output the list of attendance records
//         }
//       });
//     }).catchError((error) {
//       print('Error retrieving data: $error');
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Attendance Data'),
//       ),
//       body: attendanceData.isEmpty
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: attendanceData.length,
//               itemBuilder: (context, index) {
//                 // Each attendance entry is a map with course_id, date, etc.
//                 Map<dynamic, dynamic> attendanceEntry = attendanceData[index];
//                 Map<dynamic, dynamic> student = students[index];
//                 String name = '';
//                 print(student['id'] + attendanceEntry['student_id']);
//                 if (student['id'] == attendanceEntry['student_id']) {
//                   name = student['name'];
//                 }
//                 String courseId = attendanceEntry['course_id'] ?? 'N/A';
//                 String date = attendanceEntry['date'] ?? 'N/A';
//                 String status = attendanceEntry['status'] ?? 'N/A';
//                 String studentId = attendanceEntry['student_id'] ?? 'N/A';
//                 String timestamp = attendanceEntry['timestamp'] ?? 'N/A';

//                 return ListTile(
//                   title: Text(name),
//                   subtitle: Text('ID: ' + studentId),
//                   trailing: Text('Present'),
//                 );
//               },
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  String url =
      'https://smart-attendance-system-d6ed0-default-rtdb.firebaseio.com/attendance';
  String stdurl =
      'https://smart-attendance-system-d6ed0-default-rtdb.firebaseio.com/students';
  List<Map<dynamic, dynamic>> attendanceData = [];
  List<Map<dynamic, dynamic>> students = [];
  late final DatabaseReference _database;
  late final DatabaseReference stddb;
  String selectedCourse = 'CSE001'; // Default course is Networking (CSE001)

  @override
  void initState() {
    super.initState();
    stddb = FirebaseDatabase.instance.refFromURL(stdurl);
    _database = FirebaseDatabase.instance.refFromURL(url);
    fetchAttendanceData();
    fetchStudentsData();
  }

  Future<void> fetchStudentsData() async {
    DatabaseReference attendanceRef = stddb;
    attendanceRef.once().then((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;

      setState(() {
        if (snapshot.value != null) {
          Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;

          students = List<Map<dynamic, dynamic>>.from(
              data.values.map((value) => value as Map<dynamic, dynamic>));
        }
      });
    }).catchError((error) {
      print('Error retrieving data: $error');
    });
  }

  // Future<void> fetchAttendanceData() async {
  //   DatabaseReference attendanceRef = _database;
  //   attendanceRef.once().then((DatabaseEvent event) {
  //     DataSnapshot snapshot = event.snapshot;

  //     setState(() {
  //       if (snapshot.value != null) {
  //         Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;

  //         attendanceData = List<Map<dynamic, dynamic>>.from(
  //             data.values.map((value) => value as Map<dynamic, dynamic>));
  //       }
  //     });
  //   }).catchError((error) {
  //     print('Error retrieving data: $error');
  //   });
  // }

  Future<void> fetchAttendanceData() async {
    // Get today's date in 'yyyy-MM-dd' format to match the schema
    String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    // Reference to the attendance data in Firebase
    DatabaseReference attendanceRef = _database.child('attendance');

    try {
      DatabaseEvent event = await attendanceRef.once();
      DataSnapshot snapshot = event.snapshot;

      if (snapshot.value != null) {
        Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;

        print("Fetched data: $data"); // Debugging step

        setState(() {
          // Filter only attendance records where the 'date' matches today's date
          attendanceData =
              List<Map<dynamic, dynamic>>.from(data.values.where((attendance) {
            print(
                "Checking attendance date: ${attendance['date']}"); // Debugging step
            return attendance['date'] == todayDate;
          }).map((attendance) {
            print(
                "Adding attendance for student: ${attendance['student_id']}"); // Debugging step
            return {
              'course_id': attendance['course_id'],
              'student_id': attendance['student_id'],
              'status': attendance['status'],
              'timestamp': attendance['timestamp'],
            };
          }));
          print("Attendance data updated: $attendanceData"); // Debugging step
        });
      } else {
        print("No data found.");
      }
    } catch (error) {
      print('Error retrieving attendance data: $error');
    }
  }

  List<Map<dynamic, dynamic>> getFilteredAttendance(String courseId) {
    return attendanceData.where((entry) {
      return entry['course_id'] == courseId;
    }).toList();
  }

  String getStudentName(String studentId) {
    String name = 'Unknown';
    for (var student in students) {
      if (student['student_id'] == studentId) {
        name = student['name'];
        break;
      }
    }
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Tracker'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: attendanceData.isEmpty || students.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Courses',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800]),
                  ),
                  // SizedBox(height: 16),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     buildCourseButton('Networking', 'CSE001'),
                  //     buildCourseButton('IoT', 'CSE003'),
                  //   ],
                  // ),
                  SizedBox(height: 24),
                  buildAttendanceList('CSE002', 'Networking'),
                  SizedBox(height: 16),
                  buildAttendanceList('CSE003', 'Cloud Coumputing'),
                  SizedBox(height: 16),
                  buildAttendanceList('CSE004', 'Technicle Writing'),
                  SizedBox(height: 16),
                  buildAttendanceList('CSE001', 'IoT'),
                ],
              ),
            ),
    );
  }

  Widget buildCourseButton(String title, String courseId) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedCourse = courseId;
        });
      },
      child: Text(
        title,
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor:
            selectedCourse == courseId ? Colors.green : Colors.grey.shade400,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  Widget buildAttendanceList(String courseId, String courseTitle) {
    List<Map<dynamic, dynamic>> filteredAttendance =
        getFilteredAttendance(courseId);

    return ExpansionTile(
      initiallyExpanded: selectedCourse == courseId,
      title: Text(
        courseTitle,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      children: [
        filteredAttendance.isEmpty
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('No attendance records found'),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: filteredAttendance.length,
                itemBuilder: (context, index) {
                  Map<dynamic, dynamic> attendanceEntry =
                      filteredAttendance[index];
                  String studentId = attendanceEntry['student_id'];
                  String studentName = getStudentName(studentId);
                  DateTime parsedDate = DateTime.parse(
                      attendanceEntry['timestamp'] ?? '2024-12-05');
                  String timestamp = DateFormat('hh:mm a').format(parsedDate);

                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(12),
                      title: Text(
                        studentName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      subtitle: Text(
                        'ID: $studentId\nTime: $timestamp',
                        style: TextStyle(fontSize: 14),
                      ),
                      trailing: Text(
                        attendanceEntry['status'] ?? 'N/A',
                        style: TextStyle(
                          fontSize: 16,
                          color: attendanceEntry['status'] == 'present'
                              ? Colors.green
                              : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
      ],
    );
  }
}
