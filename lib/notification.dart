// notification.dart

import 'package:flutter/material.dart';

import 'job_page.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // First Notification Block
          _buildNotificationBlock(
            companyName: 'Indexnine',
            ctc: '5.5 lakh',
            jobTitle: 'Software Developer',
            location: 'Baner',
            eligibility: '60% above in all academics',
            context: context,
          ),

          // Second Notification Block
          _buildNotificationBlock(
            companyName: 'Indexnine',
            ctc: '5.5 lakh',
            jobTitle: 'Software Tester',
            location: 'Baner',
            eligibility: '60% above in all academics',
            context: context,
          ),

          // Third Notification Block
          _buildNotificationBlock(
            companyName: 'Rockwell',
            ctc: '8 lakh',
            jobTitle: 'Consultancy',
            location: 'Baner',
            eligibility: '60% above in all academics', context: context,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationBlock({
    required String companyName,
    required String ctc,
    required String jobTitle,
    required String location,
    required String eligibility,
    required BuildContext context, // Pass the context as a parameter
  }) {
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
          const SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: () {
              // Handle the action when the "View" button is pressed
              // Navigate to the JobPage
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
                    const JobPage()), // Adjust the route accordingly
              );
            },
            child: const Text('View'),
          ),
        ],
      ),
    );
  }
}
