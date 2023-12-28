import 'package:application/fileupload.dart';
import 'package:flutter/material.dart';
import 'camera.dart';
import 'list.dart'; // Import the second screen Dart file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/first': (context) =>  const CameraPage(),
        '/second':(context) => const UploadPage(),
        '/third': (context) => ListScreen(), // Define the route to the second screen
        
      },
       theme: ThemeData(
        primaryColor: Colors.green // Set the primary color of the app
        //hintColor: Colors.green, // Set the accent color (used for buttons)
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rice Leaf Detection',),
        backgroundColor: Theme.of(context).primaryColor, // Use the primary color for the app bar
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 50),
             ElevatedButton.icon(
              onPressed: () {
                // Add functionality for the first button here
                Navigator.pushNamed(context, '/first');
              },
              icon: const Icon(Icons.camera), // Add an icon
              label: const Text('CAMERA'),
              style: ElevatedButton.styleFrom(
                 backgroundColor: Colors.green,
              )
              
            ),
            const SizedBox(height: 50),
             ElevatedButton.icon(
              onPressed: () {
                // Add functionality for the first button here
                Navigator.pushNamed(context, '/second');
              },
              icon: const Icon(Icons.upload), // Add an icon
              label: const Text('Upload'),
              style: ElevatedButton.styleFrom(
                 backgroundColor: Colors.green,
              )
             
            ),
            const SizedBox(height: 50),
            ElevatedButton.icon(
              onPressed: () {
                // Navigate to the second screen when Button 2 is pressed
                Navigator.pushNamed(context, '/third');
              },
              icon: const Icon(Icons.bug_report), // Add an icon
              label: const Text('DISEASES'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              
            ),
         )],
        ),
      ),
      backgroundColor: Colors.white, // Set the background color of the screen
    );
  }
}