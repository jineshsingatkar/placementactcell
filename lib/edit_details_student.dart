import 'package:flutter/material.dart';

class EditStudentDetailsPage extends StatelessWidget {
  const EditStudentDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Student Details'),
      ),
      body: SingleChildScrollView( // Use SingleChildScrollView to enable scrolling
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Full Name'),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Address'),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Date of Birth'),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              decoration: const InputDecoration(labelText: '10th marks'),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              decoration: const InputDecoration(labelText: '12th marks'),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              decoration: const InputDecoration(labelText: 'graduation degree name'),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              decoration: const InputDecoration(labelText: 'graduation percentage'),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              decoration: const InputDecoration(labelText: 'pg degree name'),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              decoration: const InputDecoration(labelText: 'pg percentage'),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                // Handle form submission to update student details
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
