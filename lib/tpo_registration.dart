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

      await _firestore.collection('tpo').doc(userCredential.user?.uid).set({
        'name': nameController.text,
        'college': orgController.text,
        'password': passwordController.text,
        'email': emailController.text,
      });

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TPOLoginPage()));
    } catch (e) {
      print('Registration failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration failed: $e'),
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
          'TPO Registration',
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
                SizedBox(height: size.height * 0.02),
                Image.asset(
                  'assets/siom_logo.jpeg',
                  width: size.width * 0.3,
                  height: size.width * 0.3,
                ),
                SizedBox(height: size.height * 0.03),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
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
                  controller: orgController,
                  decoration: InputDecoration(
                    labelText: 'Organization/College',
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
                SizedBox(height: size.height * 0.02),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Re-enter Password',
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
                SizedBox(height: size.height * 0.04),
                ElevatedButton(
                  onPressed: _registerUser,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.02,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontSize: isPortrait ? size.width * 0.045 : size.height * 0.025,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                ElevatedButton(
                  onPressed: () {
                    // Handle Google registration
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.02,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/google_logo.png',
                        height: size.height * 0.03,
                        width: size.height * 0.03,
                      ),
                      SizedBox(width: size.width * 0.02),
                      Text(
                        'Register with Google',
                        style: TextStyle(
                          fontSize: isPortrait ? size.width * 0.04 : size.height * 0.022,
                        ),
                      ),
                    ],
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
