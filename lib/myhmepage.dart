// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:iotapp/attendance.dart';

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   late final db;
//   String url =
//       'https://facial-rec-attend-sys-default-rtdb.firebaseio.com/attendance';
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     db = FirebaseDatabase.instance.refFromURL(url);
//     fetchAttendanceData();
//   }

//   Map<dynamic, dynamic> attendanceData = {};
//   String att = '';
//   Future<void> fetchAttendanceData() async {
//     DatabaseReference attendanceRef = db;

//     attendanceRef.once().then((DatabaseEvent event) {
//       DataSnapshot snapshot = event.snapshot;

//       setState(() {
//         attendanceData = snapshot.value as Map<dynamic, dynamic>;
//         att = attendanceData.length.toString();
//         print(att);
//         print(attendanceData); // Output will contain the time for the student
//       });
//     }).catchError((error) {
//       print('Error retrieving data: $error');
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final widt = MediaQuery.of(context).size.width;
//     final heit = MediaQuery.of(context).size.height;
//     return Scaffold(
//       appBar: AppBar(),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Dashboard',
//               style: TextStyle(fontSize: 20),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             MyContainer(
//                 color: Colors.yellow.shade300,
//                 text1: 'Total Courses',
//                 text2: '6',
//                 text3: '2 Electives'),
//             GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => AttendanceScreen(),
//                     ));
//               },
//               child: MyContainer(
//                   color: Colors.red.shade300,
//                   text1: 'Attendance',
//                   text2: att,
//                   text3: '16% Absent'),
//             ),
//             MyContainer(
//                 color: Colors.blue.shade300,
//                 text1: 'Requested Leaves',
//                 text2: '7',
//                 text3: '3 Approved'),
//             SizedBox(
//               height: 10,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15.0),
//               child: Container(
//                 height: heit * .4,
//                 width: widt * 1,
//                 decoration: BoxDecoration(
//                     border: Border.all(color: Colors.black),
//                     borderRadius: BorderRadius.circular(10),
//                     color: Colors.white),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Center(
//                         child: Text('Todays Classes',
//                             style: TextStyle(fontSize: 20))),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(' Internet Of Things'),
//                         Text('Present Sdts: $att'),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class MyContainer extends StatelessWidget {
//   Color color;
//   String text1, text2, text3;
//   MyContainer(
//       {super.key,
//       required this.color,
//       required this.text1,
//       required this.text2,
//       required this.text3});

//   @override
//   Widget build(BuildContext context) {
//     final widt = MediaQuery.of(context).size.width;
//     final heit = MediaQuery.of(context).size.height;
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
//       child: Container(
//         width: widt * .9,
//         height: heit * .3,
//         decoration: BoxDecoration(
//           color: color,
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: Center(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(
//                 height: 30,
//               ),
//               Text(text1, style: TextStyle(fontSize: 20)),
//               SizedBox(
//                 height: 10,
//               ),
//               Text(text2, style: TextStyle(fontSize: 18)),
//               SizedBox(
//                 height: 10,
//               ),
//               Text(text3),
//               SizedBox(
//                 height: 10,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // class MyClassContainer extends StatelessWidget {
// //   String text1, text2, text3, text4, text5;

// //   MyClassContainer({super.key,required this.text1});

// //   @override
// //   Widget build(BuildContext context) {
// //     return const Placeholder();
// //   }
// // }

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iotapp/attendance.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iotapp/newfile.dart';
import 'package:iotapp/screens/assigncoursestd.dart';
import 'package:iotapp/screens/coursemanagement.dart';
import 'package:iotapp/screens/studentmanagment.dart'; // Add font_awesome_flutter for icons

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final db;
  String url =
      'https://smart-attendance-system-d6ed0-default-rtdb.firebaseio.com/attendance';
  String dayName = '';

  @override
  void initState() {
    super.initState();
    dayName = DateFormat('EEEE').format(DateTime.now());
    print(dayName);
    db = FirebaseDatabase.instance.refFromURL(url);
    fetchAttendanceData();
  }

  // Stream<DatabaseEvent> getCourses() {
  //   return FirebaseDatabase.instance
  //       .ref('courses')
  //       .child('schedule')
  //       .orderByChild('day')
  //       .equalTo(dayName)
  //       .onValue;
  // }

  Stream<List<Map<String, dynamic>>> getCourses() {
    // Get today's day name (e.g., 'Sunday', 'Monday')
    String today = DateFormat('EEEE').format(DateTime.now());

    // Firebase query to fetch courses with a schedule that matches today's day
    return FirebaseDatabase.instance
        .ref('courses')
        .orderByChild('schedule/$today/start_time')
        .onValue
        .map((event) {
      // Extract data from the event snapshot
      final data = event.snapshot.value as Map<dynamic, dynamic>?;

      // If data is not null, filter courses where today's schedule exists
      if (data != null) {
        return data.entries
            .where((entry) =>
                entry.value['schedule'] != null &&
                entry.value['schedule'][today] != null)
            .map((entry) {
          return {
            'name': entry.value['name'],
            'instructor': entry.value['instructor'],
          };
        }).toList();
      }

      return [];
    });
  }

  Map<dynamic, dynamic> attendanceData = {};
  String att = '';
  Future<void> fetchAttendanceData() async {
    DatabaseReference attendanceRef = db;

    attendanceRef.once().then((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;

      setState(() {
        attendanceData = snapshot.value as Map<dynamic, dynamic>;
        att = attendanceData.length.toString();
        print(att);
        print(attendanceData); // Output will contain the time for the student
      });
    }).catchError((error) {
      print('Error retrieving data: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text('Dashboard'),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                'Management Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Student Management'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StudentManagement(),
                    ));
                // Handle navigation to Student Management
              },
            ),
            ListTile(
              leading: Icon(Icons.school),
              title: Text('Enrollment'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AssignCourseScreen(),
                    ));
                // Handle navigation to Teacher Management
              },
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: Text('Course Management'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CourseManagement(),
                    ));
                // Handle navigation to Course Management
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                // Handle navigation to Profile
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Handle navigation to Settings
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  'Welcome to Dashboard',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),

              // Dashboard Stats
              // Container(
              //   height: height * .5,
              //   width: width,
              //   child: MyCard(
              //     color: Colors.yellow.shade300,
              //     icon: FontAwesomeIcons.book,
              //     title: 'Total Courses',
              //     value: '6',
              //     subtitle: '2 Electives',
              //   ),
              // ),
              const SizedBox(width: 10),
              // Attendance Card
              Container(
                height: height * .4,
                width: width,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AttendanceScreen(),
                      ),
                    );
                  },
                  child: MyCard(
                    color: Colors.red.shade300,
                    icon: FontAwesomeIcons.calendarCheck,
                    title: 'Attendance',
                    value: ' ',
                    subtitle: DateTime.now().toLocal().toString(),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     // Requested Leaves Card
              //     Expanded(
              //       child: GestureDetector(
              //         onTap: () {
              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //               builder: (context) => NewFile(),
              //             ),
              //           );
              //         },
              //         child: MyCard(
              //           color: Colors.blue.shade300,
              //           icon: FontAwesomeIcons.solidEnvelope,
              //           title: 'Requested Leaves',
              //           value: '7',
              //           subtitle: '3 Approved',
              //         ),
              //       ),
              //     ),
              //   ],
              // ),

              // const SizedBox(height: 20),

              //  Today's Classes Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  height: height * 0.4,
                  width: width,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.yellow,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Today's Courses",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal.shade700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 150,
                        child: StreamBuilder(
                          stream:
                              getCourses(), // Stream to fetch course data from Firebase
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              // // Extract the data from the snapshot
                              // final Map<dynamic, dynamic> coursesData =
                              //     snapshot.data!;
                              final List<Map<String, dynamic>> coursesData =
                                  snapshot.data!;
                              print(snapshot.data.toString());
                              print(coursesData);
                              return ListView.builder(
                                itemCount: coursesData
                                    .length, // Total number of courses
                                itemBuilder: (context, index) {
                                  // Access each course using its key
                                  // String courseKey =
                                  //     coursesData.keys.elementAt(index);
                                  // Map<dynamic, dynamic> course =
                                  //     coursesData[courseKey];
                                  print(coursesData);
                                  // Display course name and instructor
                                  return Card(
                                    child: ListTile(
                                      title: Text(
                                          'Course: ${coursesData[index]['name']}' ??
                                              "Noo"), // Course Name
                                      subtitle: Text(
                                          'Instructor: ${coursesData[index]['instructor']}' ??
                                              "Noo"), // Instructor Name
                                    ),
                                  );
                                },
                              );
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }
                            // Display a loading indicator while fetching the data
                            return Center(child: CircularProgressIndicator());
                          },
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title, value, subtitle;

  const MyCard({
    super.key,
    required this.color,
    required this.icon,
    required this.title,
    required this.value,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final heit = MediaQuery.of(context).size.height;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(20),
      width: width * 0.4,
      height: heit * .3,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 5,
            spreadRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            icon,
            size: 40,
            color: Colors.white,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
