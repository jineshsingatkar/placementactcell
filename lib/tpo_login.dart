import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:placementactcell/tpo_home_page.dart';
import 'package:placementactcell/tpo_registration.dart';

void main() {
  runApp(MaterialApp(
    home: TPOLoginPage(),
  ));
}

class TPOLoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TPOLoginPage({super.key});

  Future<void> _login(BuildContext context) async {
    try {
      final String email = emailController.text.trim().toLowerCase();
      final String password = passwordController.text.trim();

      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection('tpo').where('email', isEqualTo: email).get();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const TPOHomePage()));

    } catch (e) {
      print('Login failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TPO Login',
          style: TextStyle(
            fontSize: isPortrait ? size.width * 0.05 : size.height * 0.03,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05,
              vertical: size.height * 0.02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: size.height * 0.1),
                Image.asset(
                  'assets/siom_logo.jpeg',
                  width: size.width * 0.4,
                  height: size.width * 0.4,
                ),
                SizedBox(height: size.height * 0.05),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      fontSize: isPortrait ? size.width * 0.04 : size.height * 0.025,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: isPortrait ? size.width * 0.04 : size.height * 0.025,
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      fontSize: isPortrait ? size.width * 0.04 : size.height * 0.025,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  obscureText: true,
                  style: TextStyle(
                    fontSize: isPortrait ? size.width * 0.04 : size.height * 0.025,
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                ElevatedButton(
                  onPressed: () {
                    _login(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.02,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: isPortrait ? size.width * 0.045 : size.height * 0.025,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                TextButton(
                  onPressed: () {
                    // Handle "Forgot Password" action
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontSize: isPortrait ? size.width * 0.04 : size.height * 0.022,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TPORegistrationPage()),
                    );
                  },
                  child: Text(
                    "Don't have an account? Register here",
                    style: TextStyle(
                      fontSize: isPortrait ? size.width * 0.04 : size.height * 0.022,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
