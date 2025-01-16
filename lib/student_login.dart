import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:placementactcell/Student_home_page.dart';
import 'package:placementactcell/Student_registration.dart';

void main() {
  runApp(MaterialApp(
    home: StudentLoginPage(),
  ));
}

class StudentLoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  StudentLoginPage({super.key});



  Future<void> _login(BuildContext context) async {
    try {
      final String email = emailController.text.trim().toLowerCase();
      final String password = passwordController.text.trim();

      // Try to sign in with the provided credentials
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Check if the user exists in the selected collection based on the user type
      await _firestore.collection('student').where('email', isEqualTo: email).get();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const StudentHomePage()));

    } catch (e) {
      // Handle login error (e.g., show an error message)
      print('Login failed: $e');
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed: $e'),
        ),
      );
    }
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _login(context);
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 10.0),
            TextButton(
              onPressed: () {
                // Handle "Forgot Password" action
                // You can implement the forgot password logic here
              },
              child: const Text('Forgot Password?'),
            ),
            TextButton(
              onPressed: () {
                // Navigate to Student registration page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StudentRegistrationPage()),
                );
              },
              child: const Text("Don't have an account? Register here"),
            ),
          ],
        ),
      ),
    );
  }
}
