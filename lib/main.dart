import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:placementactcell/student_login.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp();
  
  // Initialize notification service
  await NotificationService().init();
  
  runApp(const MyApp());
}

class StudentLoginPage extends StatelessWidget {
  const StudentLoginPage({super.key});

  void _showTestNotification() async {
    await NotificationService().showNotification(
      id: 0,
      title: 'New Placement Update',
      body: 'A new company has posted a job opportunity!',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Login'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: _showTestNotification,
            tooltip: 'Test Notification',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Placement Act Cell',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _showTestNotification,
              icon: const Icon(Icons.notifications_active),
              label: const Text('Test Notification'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Placement Act Cell',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: StudentLoginPage(),
    );
  }
}
