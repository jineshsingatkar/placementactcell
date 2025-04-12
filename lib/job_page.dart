import 'package:flutter/material.dart';

class JobPage extends StatelessWidget {
  const JobPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Job Page'),
          bottom: TabBar(
            tabs: const [
              Tab(text: 'All Jobs'),
              Tab(text: 'Applied Jobs'),
            ],
            labelStyle: TextStyle(
              fontSize: isPortrait ? size.width * 0.04 : size.height * 0.025,
            ),
          ),
        ),
        body: TabBarView(
          children: [
            // All Jobs Tab
            _buildAllJobsContent(size, isPortrait),
            // Applied Jobs Tab
            const Center(
              child: Text('Applied Jobs Content'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAllJobsContent(Size size, bool isPortrait) {
    // List of job items
    List<JobItem> jobItems = [
      const JobItem(
        companyName: 'Indexnine',
        ctc: '5.5 lakh',
        jobTitle: 'Software Developer',
        location: 'Baner',
        eligibility: '60% above in all academics',
      ),
      const JobItem(
        companyName: 'Indexnine',
        ctc: '5.5 lakh',
        jobTitle: 'Software Tester',
        location: 'Baner',
        eligibility: '60% above in all academics',
      ),
      const JobItem(
        companyName: 'Rockwell',
        ctc: '8 lakh',
        jobTitle: 'Consultancy',
        location: 'Baner',
        eligibility: '60% above in all academics',
      ),
      // Add more job items as needed
    ];

    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.04,
        vertical: size.height * 0.02,
      ),
      itemCount: jobItems.length,
      itemBuilder: (context, index) {
        return jobItems[index];
      },
    );
  }
}

class JobItem extends StatelessWidget {
  final String companyName;
  final String ctc;
  final String jobTitle;
  final String location;
  final String eligibility;

  const JobItem({super.key, 
    required this.companyName,
    required this.ctc,
    required this.jobTitle,
    required this.location,
    required this.eligibility,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Card(
      margin: EdgeInsets.symmetric(
        vertical: size.height * 0.01,
      ),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(size.width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Company Name: $companyName',
              style: TextStyle(
                fontSize: isPortrait ? size.width * 0.045 : size.height * 0.025,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Text(
              'CTC: $ctc',
              style: TextStyle(
                fontSize: isPortrait ? size.width * 0.04 : size.height * 0.022,
              ),
            ),
            SizedBox(height: size.height * 0.005),
            Text(
              'Job Title: $jobTitle',
              style: TextStyle(
                fontSize: isPortrait ? size.width * 0.04 : size.height * 0.022,
              ),
            ),
            SizedBox(height: size.height * 0.005),
            Text(
              'Location: $location',
              style: TextStyle(
                fontSize: isPortrait ? size.width * 0.04 : size.height * 0.022,
              ),
            ),
            SizedBox(height: size.height * 0.005),
            Text(
              'Eligibility: $eligibility',
              style: TextStyle(
                fontSize: isPortrait ? size.width * 0.04 : size.height * 0.022,
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle the action when the "Apply" button is pressed
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.06,
                      vertical: size.height * 0.015,
                    ),
                  ),
                  child: Text(
                    'Apply',
                    style: TextStyle(
                      fontSize: isPortrait ? size.width * 0.04 : size.height * 0.022,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle the action when the "View" button is pressed
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.06,
                      vertical: size.height * 0.015,
                    ),
                  ),
                  child: Text(
                    'View',
                    style: TextStyle(
                      fontSize: isPortrait ? size.width * 0.04 : size.height * 0.022,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: JobPage(),
  ));
}
