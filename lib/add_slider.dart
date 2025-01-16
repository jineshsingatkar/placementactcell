import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:placementactcell/tpo_add_page.dart';
import 'package:placementactcell/tpo_home_page.dart';
import 'package:placementactcell/tpo_profile.dart';

class AddSliderPage extends StatefulWidget {
  final String tpoLoginId;

  const AddSliderPage({super.key, required this.tpoLoginId});

  @override
  _AddSliderPageState createState() => _AddSliderPageState();
}

class _AddSliderPageState extends State<AddSliderPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  void _submitForm() async {
    // Get the values from the controllers
    String name = _nameController.text.trim();
    String date = _dateController.text.trim();
    String message = _messageController.text.trim();

    // Validate the form (you can add more validation logic as needed)
    if (name.isEmpty || date.isEmpty || message.isEmpty) {
      // Show an error message if any field is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
        ),
      );
      return;
    }

    // Store the data in Firestore
    try {
      await FirebaseFirestore.instance.collection('slider').add({
        'name': name,
        'date': date,
        'message': message,
        // Add more fields as needed
      });

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data submitted successfully'),
        ),
      );

      // Clear the text fields after submission
      _nameController.clear();
      _dateController.clear();
      _messageController.clear();
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
        title: const Text('Add Slider'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(labelText: 'date'),
              ),
              TextFormField(
                controller: _messageController,
                decoration: const InputDecoration(labelText: 'Message'),
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
