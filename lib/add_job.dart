import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:placementactcell/tpo_add_page.dart';
import 'package:placementactcell/tpo_home_page.dart';
import 'package:placementactcell/tpo_profile.dart';

class AddJobPage extends StatefulWidget {
  final String tpoLoginId;

  const AddJobPage({super.key, required this.tpoLoginId});

  @override
  _AddJobPageState createState() => _AddJobPageState();
}

class _AddJobPageState extends State<AddJobPage> {
  final TextEditingController _Company_NameController = TextEditingController();
  final TextEditingController _CTCController = TextEditingController();
  final TextEditingController _eligibilityController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _job_profileController = TextEditingController();

  void _submitForm() async {
    // Get the values from the controllers
    String companyName = _Company_NameController.text.trim();
    String CTC = _CTCController.text.trim();
    String eligibility = _eligibilityController.text.trim();
    String location = _locationController.text.trim();
    String jobProfile = _job_profileController.text.trim();

    // ValiCTC the form (you can add more validation logic as needed)
    if (companyName.isEmpty || CTC.isEmpty || eligibility.isEmpty) {
      // Show an error eligibility if any field is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
        ),
      );
      return;
    }

    // Store the data in Firestore
    try {
      await FirebaseFirestore.instance.collection('job').add({
        'name': companyName,
        'ctc': CTC,
        'eligibility': eligibility,
        'location': location,
        'profile': jobProfile,
        // Add more fields as needed
      });

      // Show a success eligibility
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data submitted successfully'),
        ),
      );

      // Clear the text fields after submission
      _Company_NameController.clear();
      _CTCController.clear();
      _eligibilityController.clear();
      _locationController.clear();
      _job_profileController.clear();
    } catch (e) {
      // Handle any errors that occur during submission
      print('Error submitting data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error submitting data. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Job'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: _Company_NameController,
                decoration: const InputDecoration(labelText: 'Company_Name'),
              ),
              TextFormField(
                controller: _CTCController,
                decoration: const InputDecoration(labelText: 'CTC'),
              ),
              TextFormField(
                controller: _eligibilityController,
                decoration: const InputDecoration(labelText: 'Eligibility'),
              ),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Location'),
              ),
              TextFormField(
                controller: _job_profileController,
                decoration: const InputDecoration(labelText: 'Job Profile'),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const TPOHomePage()),
              );
              break;
            case 1:
            // Current page
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const TPOAddPage(tpoLoginId: '',)),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => TPOProfilePage(tpoLoginId: widget.tpoLoginId)),
              );
              break;
          }
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
