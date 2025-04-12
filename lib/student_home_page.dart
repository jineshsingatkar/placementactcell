import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'job_page.dart';
import 'job_profile.dart';
import 'student_login.dart';
import 'notification.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key});

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    if (_auth.currentUser == null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => StudentLoginPage()),
      );
    } else {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _handleLogout() async {
    try {
      await _auth.signOut();
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => StudentLoginPage()),
        );
      }
    } catch (e) {
      setState(() => _error = e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_error != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: $_error'),
              ElevatedButton(
                onPressed: () => setState(() => _error = null),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/siom_logo.jpeg',
              width: size.width * 0.1,
              height: size.width * 0.1,
            ),
            const SizedBox(width: 8.0),
            const Text('SIOM'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const StudentProfilePage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Logout"),
                    content: const Text("Are you sure you want to logout?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _handleLogout();
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
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: isPortrait ? size.height * 0.25 : size.height * 0.4,
                child: StreamBuilder(
                  stream: _firestore.collection('slider').snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text('No events available'));
                    }

                    List<DocumentSnapshot> documents = snapshot.data!.docs;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        var doc = documents[index];
                        return _buildEventBlock(
                          title: doc['name'] ?? 'Untitled',
                          date: doc['date'] ?? 'No date',
                          details: doc['message'] ?? 'No details',
                          size: size,
                          isPortrait: isPortrait,
                        );
                      },
                    );
                  },
                ),
              ),
              const Divider(color: Colors.black, thickness: 1.0),
              StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('events').orderBy('date', descending: true).limit(5).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No events available'));
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var event = snapshot.data!.docs[index];
                      return _buildEventListItem(event, size, isPortrait);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {},
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

  Widget _buildEventBlock({
    required String title,
    required String date,
    required String details,
    required Size size,
    required bool isPortrait,
  }) {
    return Container(
      width: isPortrait ? size.width * 0.8 : size.width * 0.4,
      margin: EdgeInsets.all(size.width * 0.02),
      padding: EdgeInsets.all(size.width * 0.04),
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: isPortrait ? size.width * 0.05 : size.height * 0.03,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Text(
            date,
            style: TextStyle(
              fontSize: isPortrait ? size.width * 0.04 : size.height * 0.025,
              color: Colors.white70,
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Text(
            details,
            style: TextStyle(
              fontSize: isPortrait ? size.width * 0.035 : size.height * 0.02,
              color: Colors.white,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildEventListItem(DocumentSnapshot event, Size size, bool isPortrait) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.04,
        vertical: size.height * 0.01,
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: size.width * 0.04,
          vertical: size.height * 0.01,
        ),
        title: Text(
          event['name'] ?? 'Untitled',
          style: TextStyle(
            fontSize: isPortrait ? size.width * 0.045 : size.height * 0.025,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event['date'] ?? 'No date',
              style: TextStyle(
                fontSize: isPortrait ? size.width * 0.035 : size.height * 0.02,
              ),
            ),
            Text(
              event['message'] ?? 'No details',
              style: TextStyle(
                fontSize: isPortrait ? size.width * 0.035 : size.height * 0.02,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
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
              'the National Education Policy 2020 stresses on the core values and principle that education must develop not only the cognitive skills, that is, – both 'foundational skills' of literacy and numeracy and 'higher-order' skills such as critical thinking and problem solving – but also, social and emotional skills - also referred to as 'soft skills' -including cultural awareness and empathy, perseverance and grit, teamwork, leadership, communication, among others. The Policy aims and aspires to universalize the pre-primary education and provides special emphasis on the attainment of foundational literacy/numeracy in primary school and beyond for all by 2025. It recommends plethora of reforms at all levels of school education which seek to ensure quality of schools, transformation of the curriculum including pedagogy with 5+3+3+4 design covering children in the age group 3-18 years, reform in the current exams and assessment system, strengthening of teacher training, and restructuring the education regulatory framework. It seeks to increase public investment in education, strengthen the use of technology and increase focus on vocational and adult education, among others. It recommends that the curriculum load in each subject should be reduced to its 'core essential' content by making space for holistic, discussion and analysis-based learning.',
              style: TextStyle(fontSize: 16.0),
            ),
            // Add more content as needed
          ],
        ),
      ),
    );
  }
}