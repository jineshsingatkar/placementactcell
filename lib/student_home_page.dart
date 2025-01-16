import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'job_page.dart';
import 'job_profile.dart';
import 'main.dart';
import 'notification.dart';

void main() {
  runApp(const MaterialApp(
    home: StudentHomePage(),
  ));
}

class StudentHomePage extends StatelessWidget {
  const StudentHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/siom_logo.jpeg', width: 40.0, height: 40.0),
            const SizedBox(width: 5.0),
            const Text('SIOM'),
          ],
        ),
        actions: [
          // Profile Icon
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Navigate to the profile page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const StudentProfilePage()),
              );
            },
          ),
          // Notification Icon
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Navigate to the notifications page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationPage()), // Use NotificationPage here
              );
            },
          ),
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
          // Slider for Feeds (Upcoming Companies and Events)
          SizedBox(
            height: 150.0,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('slider').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator(); // Loading indicator
                }

                List<DocumentSnapshot> documents = snapshot.data!.docs;

                return ListView(
                  scrollDirection: Axis.horizontal,
                  children: documents.map((doc) {
                    return _buildEventBlock(
                      title: doc['name'],
                      date: doc['date'],
                      details: doc['message'],
                    );
                  }).toList(),
                );
              },
            ),
          ),
          // Horizontal Line
          const Divider(
            color: Colors.black,
            thickness: 1.0,
          ),
          // Event Description
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'EVENT1',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'The National Education Policy 2020 stresses on the core values and principles...',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to a page with the full description on tap
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FullDescriptionPage(),
                      ),
                    );
                  },
                  child: const Text(
                    'Read more',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StudentHomePage()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.work),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const JobPage()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                // Navigate to the profile page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StudentProfilePage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
Widget _buildEventBlock({
  required String title,
  required String date,
  required String details,
}) {
  return Container(
    width: 200.0, // Set the width of each block
    margin: const EdgeInsets.all(8.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.blueGrey, // Customize the background color
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          'Date: $date',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          details,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),

      ],
    ),
  );

}
class ExpandableDescription extends StatefulWidget {
  final String description;

  const ExpandableDescription({required this.description, super.key});

  @override
  _ExpandableDescriptionState createState() => _ExpandableDescriptionState();
}

class _ExpandableDescriptionState extends State<ExpandableDescription> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final String shortDescription = widget.description.split('\n').take(3).join('\n');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isExpanded ? widget.description : shortDescription,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8.0),
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Text(
            isExpanded ? 'Read less' : 'Read more',
            style: const TextStyle(
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }
}
class FullDescriptionPage extends StatelessWidget {
  const FullDescriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Description'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'EVENT1',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'the National Education Policy 2020 stresses on the core values and principle that education must develop not only the cognitive skills, that is, – both ‘foundational skills’ of literacy and numeracy and ‘higher-order’ skills such as critical thinking and problem solving – but also, social and emotional skills - also referred to as ‘soft skills’ -including cultural awareness and empathy, perseverance and grit, teamwork, leadership, communication, among others. The Policy aims and aspires to universalize the pre-primary education and provides special emphasis on the attainment of foundational literacy/numeracy in primary school and beyond for all by 2025. It recommends plethora of reforms at all levels of school education which seek to ensure quality of schools, transformation of the curriculum including pedagogy with 5+3+3+4 design covering children in the age group 3-18 years, reform in the current exams and assessment system, strengthening of teacher training, and restructuring the education regulatory framework. It seeks to increase public investment in education, strengthen the use of technology and increase focus on vocational and adult education, among others. It recommends that the curriculum load in each subject should be reduced to its ‘core essential’ content by making space for holistic, discussion and analysis-based learning.',
              style: TextStyle(fontSize: 16.0),
            ),
            // Add more content as needed
          ],
        ),
      ),
    );
  }
}