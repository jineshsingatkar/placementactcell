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
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      home: const StudentLoginPage(),
    );
  }
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
    final size = MediaQuery.of(context).size;
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05,
              vertical: size.height * 0.02,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: size.height * 0.1),
                Text(
                  'Welcome to Placement Act Cell',
                  style: TextStyle(
                    fontSize: isPortrait ? size.width * 0.06 : size.height * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: size.height * 0.05),
                ElevatedButton.icon(
                  onPressed: _showTestNotification,
                  icon: const Icon(Icons.notifications_active),
                  label: const Text('Test Notification'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.02,
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
