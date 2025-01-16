import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:placementactcell/main.dart';
import 'package:placementactcell/tpo_add_page.dart';
import 'package:placementactcell/tpo_profile.dart';

void main() {
  runApp(const MaterialApp(
    home: TPOHomePage(),
  ));
}

class TPOHomePage extends StatefulWidget {
  const TPOHomePage({super.key});

  @override
  _TPOHomePageState createState() => _TPOHomePageState();
}

class _TPOHomePageState extends State<TPOHomePage> {
  late TextEditingController _searchController;
  int _currentIndex = 0;
  String? tpoLoginId; // Store the TPO login ID

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();

    // Simulate user authentication and retrieve TPO login ID
    simulateUserLogin();
  }

  void simulateUserLogin() async {
    // Simulate user login and get the TPO login ID
    // Replace this with your actual authentication logic
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      tpoLoginId = 'example_tpo_login_id';
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TPO Home Page'),
        actions: [
          // Logout Icon
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              // Implement the logout logic here
              // For example, show a confirmation dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Logout"),
                    content: const Text("Are you sure you want to logout?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          // Implement actual logout logic
                          // For now, just pop back to the login page
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const MyApp()),
                          );
                        },
                        child: const Text("Logout"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search by Name',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {});
                  },
                ),
              ),
              onChanged: (value) => setState(() {}),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('student').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                List<QueryDocumentSnapshot<Map<String, dynamic>>>? students = snapshot.data?.docs
                    .cast<QueryDocumentSnapshot<Map<String, dynamic>>>()
                    .where((student) =>
                    student['name'].toLowerCase().contains(_searchController.text.toLowerCase()))
                    .toList();

                return ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    QueryDocumentSnapshot<Map<String, dynamic>>? student = students[index];
                    String studentName = student?['name'] ?? ''; // Get student name

                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Student Details',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Text('Student Name: $studentName'),

                            // Button to show entities for the selected student
                            ElevatedButton(
                              onPressed: () {
                                // Navigate to a new screen or dialog to show entities
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        StudentEntitiesScreen(studentId: student!.id),
                                  ),
                                );
                              },
                              child: const Text('Show Entities'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            // Navigate to the respective pages based on the tapped index
            switch (index) {
              case 0:
              // Home
                break;
            // Inside TPOHomePage

              case 1:
              // Add
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TPOAddPage(tpoLoginId: tpoLoginId ?? '')),
                );
                break;

              case 2:
              // Profile
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TPOProfilePage(tpoLoginId: tpoLoginId ?? '')),
                );
                break;
            }
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class StudentEntitiesScreen extends StatelessWidget {
  final String studentId;

  const StudentEntitiesScreen({super.key, required this.studentId});

  Future<Map<String, dynamic>?> fetchStudentDetails(String studentId) async {
    try {
      // Fetch the entire student document from Firestore based on the student ID
      DocumentSnapshot<Map<String, dynamic>> studentSnapshot =
      await FirebaseFirestore.instance.collection('student').doc(studentId).get();

      // Return the student details as a map
      return studentSnapshot.data();
    } catch (e) {
      print('Error fetching student details: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Entities'),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: fetchStudentDetails(studentId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error fetching student details'),
            );
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: Text('Student details not found'),
            );
          }

          // Display all details for the selected student
          Map<String, dynamic> studentDetails = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Student ID: ${studentDetails['studentId']}'),
                Text('College: ${studentDetails['college']}'),
                Text('Name: ${studentDetails['name']}'),
                Text('Email: ${studentDetails['email']}'),

                // Display additional details from the student document
                // Modify this section according to your document structure
                // For example:
                // Text('Field1: ${studentDetails['field1']}'),
                // Text('Field2: ${studentDetails['field2']}'),
                // ...

              ],
            ),
          );
        },
      ),
    );
  }
}
