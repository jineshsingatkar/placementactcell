import 'package:flutter/material.dart';

class JobPage extends StatelessWidget {
  const JobPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Job Page'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'All Jobs'),
              Tab(text: 'Applied Jobs'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // All Jobs Tab
            _buildAllJobsContent(),
            // Applied Jobs Tab
            const Center(
              child: Text('Applied Jobs Content'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAllJobsContent() {
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
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Company Name: $companyName'),
          Text('CTC: $ctc'),
          Text('Job Title: $jobTitle'),
          Text('Location: $location'),
          Text('Eligibility: $eligibility'),
          const SizedBox(height: 10.0), // Add spacing for the buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Handle the action when the "Apply" button is pressed
                  // You can navigate to an application form or perform other actions here
                },
                child: const Text('Apply'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle the action when the "View" button is pressed
                  // You can navigate to a detailed view or perform other actions here
                },
                child: const Text('View'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: JobPage(),
  ));
}
