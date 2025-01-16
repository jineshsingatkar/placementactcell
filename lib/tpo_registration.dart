import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:placementactcell/tpo_login.dart';



class TPORegistrationPage extends StatefulWidget {
  const TPORegistrationPage({super.key});

  @override
  _TPORegistrationPageState createState() => _TPORegistrationPageState();

}

class _TPORegistrationPageState extends State<TPORegistrationPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController orgController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _registerUser() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );


      // Store user details in Firestore
      await _firestore.collection('tpo').doc(userCredential.user?.uid).set({
        'name': nameController.text,
        'college': orgController.text,
        'password': passwordController.text,
        'email': emailController.text,
      });

      // Redirect to the WelcomePage.
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TPOLoginPage()));
    } catch (e) {
      // Handle registration error (e.g., show an error message)
      print('Registration failed: $e');

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration failed: $e'),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TPO Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: nameController, // Add this line
              decoration: const InputDecoration(labelText: 'Full Name'),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: emailController, // Add this line
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: orgController, // Add this line
              decoration: const InputDecoration(labelText: 'Organization/College'),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: passwordController, // Add this line
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 10.0),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'Re-enter Password'),
            ),

            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed:_registerUser,
              child: const Text('Register'),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                // Handle Google registration
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset('assets/google_logo.png', height: 20.0, width: 20.0),
                  const SizedBox(width: 10.0),
                  const Text('Register with Google'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
